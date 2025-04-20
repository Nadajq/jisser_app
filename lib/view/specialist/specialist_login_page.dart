import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/auth/auth_specialists.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/view/specialist/booking_list_page.dart';
import 'package:jisser_app/view/specialist/specialist_signup_page.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SpecialistLoginPage extends StatefulWidget {
  const SpecialistLoginPage({super.key});

  @override
  State<SpecialistLoginPage> createState() => _SpecialistLoginPageState();
}

class _SpecialistLoginPageState extends State<SpecialistLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validate inputs
    if (_emailController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_email,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_password,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthSpecialists().loginSpecialist(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        // Check specialists table
        final specialistResponse = await Supabase.instance.client
            .from('specialists')
            .select()
            .eq('email', _emailController.text)
            .maybeSingle();

        if (specialistResponse != null) {
          // Check if account is active
          if (specialistResponse['active'] == false) {
            CustomSnackBar.snackBarwidget(
              context: context,
              color: Colors.red,
              text: 'الرجاء الانتظار حتى يتم تنشيط حسابك',
            );
            return;
          }

          // User found in specialists table and account is active
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingListPage(
                        specialist: Specialist(
                          id: specialistResponse['id'],
                          name: specialistResponse['name'],
                          email: specialistResponse['email'],
                          imageUrl: specialistResponse['image_url'],
                          pdfUrl: specialistResponse['pdf_url'],
                          specialty: specialistResponse['specialty'],
                          qualification: specialistResponse['qualification'],
                          yearsOfExperience:
                              specialistResponse['years_of_experience'],
                          rating: specialistResponse['rating'],
                          sessionTimes: specialistResponse['session_times'],
                          sessionDurations:
                              specialistResponse['session_durations'],
                          date: specialistResponse['date'],
                        ),
                      )));
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.green,
            text: S.of(context).login_successfully,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        if (e.toString().contains("هذا البريد الإلكتروني غير مسجل كأخصائي")) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).this_email_is_not_registered_as_specialist,
          );
        } else if (e.toString().contains("Invalid login credentials")) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).your_email_or_password_is_incorrect,
          );
        } else if (e.toString().contains("Connection timed out")) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).check_your_internet_connection,
          );
        } else {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).there_was_an_error_try_again_later,
          );
        }
        log("Login error: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLangaugeCubit, ChangeLangaugeState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Container(
                  padding: const EdgeInsets.all(7),
                  child: PopupMenuButton<int>(
                    icon: const Icon(Icons.menu, color: Colors.blueAccent),
                    offset: const Offset(0, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: ListTile(
                          title: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              const Icon(Icons.language,
                                  color: Colors.blueAccent, size: 20),
                              const SizedBox(width: 5),
                              Text(S.of(context).change_language,
                                  style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                          onTap: () {
                            BlocProvider.of<ChangeLangaugeCubit>(context)
                                .changeLangauge();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              const Icon(Icons.exit_to_app,
                                  color: Color(0xfff90606), size: 20),
                              const SizedBox(width: 5),
                              Text(S.of(context).back,
                                  style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/waiting_logo.png',
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      S.of(context).jisser,
                      style: const TextStyle(
                        color: Color(0xFF071164),
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        S.of(context).login_as_specialist,
                        style: const TextStyle(
                          color: Color(0xFF071164),
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContainerWidget(
                      controller: _emailController,
                      hintText: S.of(context).email,
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 20),
                    FormContainerWidget(
                      controller: _passwordController,
                      hintText: S.of(context).password,
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _isLoading ? null : _handleLogin,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _isLoading ? Colors.grey : Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  S.of(context).login_in,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SpecialistSignupPage(),
                              ),
                            );
                          },
                          child: Text(
                            S.of(context).create_specialist_account,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(S.of(context).you_dont_have_an_account),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
