import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:http/http.dart' as http;
import 'package:jisser_app/model/users_model.dart';
import 'package:jisser_app/view/waiting_page%20.dart';
//import 'package:jisser_app/view/waiting_page.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../control/Stripe_keys.dart';
import '../model/sessions_model.dart';

class SpecialistInfoPage extends StatefulWidget {
  final Specialist specialist;
  final Users users;
  const SpecialistInfoPage(
      {super.key, required this.specialist, required this.users});

  @override
  _SpecialistInfoPageState createState() => _SpecialistInfoPageState();
}

class _SpecialistInfoPageState extends State<SpecialistInfoPage> {
  bool _isLoading = false;
  String? _selectedTime;
  String? _selectedDuration;
  Sessions? session;
  double amount = 20;
  Map<String, dynamic>? intentPaymentData;

  makeIntentForPayment(amountToBeCharge, currency) async {
    try {
      Map<String, dynamic>? paymentInfo = {
        "amount": (int.parse(amountToBeCharge) * 100).toString(),
        "currency": currency,
        "payment_method_types[]": "card",
      };
      //send request to stripe API
      var responseFromStripeAPI = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: paymentInfo,
          headers: {
            "Authorization": "Bearer $Secretkey",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      print("response from API = " + responseFromStripeAPI.body);

      return jsonDecode(responseFromStripeAPI.body);
    } catch (errorMsg) {
      if (kDebugMode) {
        print(errorMsg);
      }
      print(errorMsg.toString());
    }
  }

  paymentSheetInitialization(amountToBeCharge, currency) async {
    try {
      intentPaymentData =
      await makeIntentForPayment(amountToBeCharge, currency);
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: intentPaymentData!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "جسر",
            primaryButtonLabel: "Pay", // Customizing the button text
          ))
          .then((val) {
        print(val);
      });
      // showPaymentSheet();
    } catch (errorMsg, s) {
      if (kDebugMode) {
        print(s);
      }
      print(errorMsg.toString());
    }
  }

  Future<void> _handleSessionBooking() async {
    if (_selectedTime == null || _selectedDuration == null) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_select_time_and_duration,
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      // 1. Handle Payment
      await _processPayment();

      // 2. Create Session
      session = await _createSession();

      // 3. Navigate to Waiting Page
      if (mounted) {
        CustomSnackBar.snackBarwidget(
          context: context,
          text: S.of(context).the_session_has_been_booked_successfully,
          color: Colors.green,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WaitingPage(
              user: widget.users,
              specialist: widget.specialist,
              date: _selectedTime!,
              session: session!,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.snackBarwidget(
          context: context,
          text: _getErrorMessage(e.toString()),
          color: Colors.red,
        );
        // print('Booking error: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _processPayment() async {
    try {
      await paymentSheetInitialization(amount.round().toString(), "aed");
      await showPaymentSheet();
    } catch (e) {
      throw Exception('فشل في عملية الدفع: ${e.toString()}');
    }
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) {
        intentPaymentData = null;
      }).onError((error, stackTrace) {
        throw Exception('Payment cancelled');
      });
    } on StripeException catch (error) {
      throw Exception('Payment cancelled $error');
    } catch (errorMsg) {
      throw Exception(errorMsg.toString());
    }
  }

  Future<Sessions> _createSession() async {
    try {
      // Create a new session object
      final session = Sessions(
        sessionId: "0", // Temporary ID, will be replaced after insertion
        specialistId: widget.specialist.id,
        userId: widget.users.id,
        sessionDate:
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
        sessionTime: _selectedTime!,
        duration: _selectedDuration!,
        active: true,
        chatId: "0",
      );

      // Insert the session into the Supabase table
      await Supabase.instance.client.from('sessions').insert({
        'specialist_id': session.specialistId,
        'user_id': session.userId,
        'session_date': session.sessionDate,
        'session_time': session.sessionTime,
        'duration': session.duration,
        'active': session.active,
        'chat_id': session.chatId,
        "created_at": DateTime.now().toIso8601String(),
      });

      // Fetch the last inserted session
      final response = await Supabase.instance.client
          .from('sessions')
          .select()
          .eq('specialist_id', session.specialistId)
          .eq('user_id', session.userId)
          .order('created_at', ascending: false) // Order by creation time
          .limit(1)
          .single();

      // Map the response to a Sessions object
      var updatedSession = Sessions(
        sessionId: response['id']?.toString() ?? '',
        specialistId: response['specialist_id']?.toString() ?? '',
        userId: response['user_id']?.toString() ?? '',
        sessionDate: response['session_date'] ?? '',
        sessionTime: response['session_time'] ?? '',
        duration: response['duration'] ?? '',
        active: response['active'] ?? false,
        chatId: response['chat_id']?.toString(),
      );

      return updatedSession;
    } catch (e) {
      throw Exception('فشل في حفظ بيانات الجلسة: ${e.toString()}');
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('Connection')) {
      return S.of(context).check_your_internet_connection;
    } else if (error.contains('payment')) {
      return S.of(context).failed_to_pay;
    } else if (error.contains('cancelled')) {
      return S.of(context).cancelled;
    } else {
      return S.of(context).there_was_an_error_selecting_session;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
            onPressed: () => Navigator.pop(context),
          ),
          title: Center(
              child:
              Image.asset('assets/jisserLogo.jpeg', width: 40, height: 40)),
          actions: const [SizedBox(width: 48)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: widget.specialist.imageUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.specialist.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF546E78)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.specialist.specialty,
                          style:
                          TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                InfoRow(
                    icon: Icons.school,
                    label: S.of(context).qualification,
                    value: widget.specialist.qualification),
                InfoRow(
                    icon: Icons.history,
                    label: S.of(context).years_of_experience,
                    value: widget.specialist.yearsOfExperience),
                InfoRow(
                    icon: Icons.menu_book,
                    label: S.of(context).offer_sessions,
                    value: S.of(context).writing),
                InfoRow(
                    icon: Icons.calendar_month,
                    label:S.of(context).session_date,
                    value: widget.specialist.date),
                const SizedBox(height: 24),
                Text(S.of(context).session_time,
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.specialist.sessionTimes!.map((time) {
                    return buildRadioButton(time, _selectedTime, (value) {
                      setState(() => _selectedTime = value!);
                    });
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text(S.of(context).session_duration,
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.specialist.sessionDurations!.map((duration) {
                    return FittedBox(
                      child: buildRadioButton(duration, _selectedDuration,
                              (value) {
                            setState(() => _selectedDuration = value!);
                          }),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSessionBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                        :  Text(
                      S.of(context).book_session  ,
                      style: const  TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton(
      String text, String? groupValue, Function(String?) onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: text,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() => onChanged(value));
          },
        ),
        Text(text),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          SizedBox(width: 8),
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[700])),
          )
        ],
      ),
    );
  }
}
