import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:http/http.dart'as http;
import '../control/Stripe_keys.dart';
import '../model/sessions_model.dart';

// الصفحة الرئيسية للطبيب المتخصص
class SpecialistInfoPage extends StatefulWidget {
  final Specialist specialist; // Receive the specialist data
  const SpecialistInfoPage({Key? key, required this.specialist})
      : super(key: key);

  @override
  _SpecialistInfoPageState createState() => _SpecialistInfoPageState();
}

// الفئة المسؤولة عن الحالة والتفاعل مع واجهة المستخدم
class _SpecialistInfoPageState extends State<SpecialistInfoPage> {
  // متغيرات لحفظ الخيارات المحددة

  String? _selectedTime ;// Store selected time
  String? _selectedDuration; // Store selected duration

  double amount = 20;
  Map<String,dynamic>? intentPaymentData;

  showPaymentSheet()async{
    try{

      await Stripe.instance.presentPaymentSheet().then((val)
      {
        intentPaymentData = null;
      }).onError((errorMsg, sTrace){
        if(kDebugMode){
          print(errorMsg.toString()+ sTrace.toString());
        }
      });

    }
    on StripeException catch(error)
    {
      if(kDebugMode){
        print(error);
      }
      showDialog(
          context: context,
          builder: (c)=> const AlertDialog(
            content: Text("Cancelled"),
          ));
    }
    catch(errorMsg,s) {
      if(kDebugMode){
        print(s);
      }
      print(errorMsg.toString());
    }
  }

  makeIntentForPayment(amountToBeCharge,currency) async{
    try{
      Map<String,dynamic>? paymentInfo=
          {
            "amount": (int.parse(amountToBeCharge)* 100 ).toString(),
            "currency": currency,
            "payment_method_types[]": "card",
          };
      //send request to stripe API
      var responseFromStripeAPI = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers:
          {
            "Authorization": "Bearer $Secretkey",
            "Content-Type": "application/x-www-form-urlencoded"
          }
      );
      print("response from API = "+ responseFromStripeAPI.body);

      return jsonDecode(responseFromStripeAPI.body);
    }
    catch(errorMsg) {
      if(kDebugMode){
        print(errorMsg);
      }
      print(errorMsg.toString());
    }
  }

  paymentSheetInitialization(amountToBeCharge , currency)async{
    try{

      intentPaymentData = await makeIntentForPayment(amountToBeCharge,currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: intentPaymentData!["client_secret"],
          style: ThemeMode.dark,
          merchantDisplayName: "جسر",
          primaryButtonLabel: "Pay", // Customizing the button text
        )
      ).then((val)
      {
        print(val);
      });
      showPaymentSheet();
    }
    catch(errorMsg,s) {
      if(kDebugMode){
        print(s);
      }
      print(errorMsg.toString());
    }
    }



  @override
  void initState(){
    super.initState();//تعيين أول وقت كقيمة افتراضية
    if(widget.specialist.sessionTimes.isNotEmpty){
      _selectedTime = widget.specialist.sessionTimes.first; // تعيين أول وقت كافتراضي
    }
    // تعيين أول مدة كقيمة افتراضية
    if (widget.specialist.sessionDurations.isNotEmpty) {
      _selectedDuration = widget.specialist.sessionDurations.first; // تعيين أول مدة كافتراضي
    }
  }

  Widget build(BuildContext context) {

    return Directionality(
      // لضبط اتجاه النص والعناصر من اليمين إلى اليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
            onPressed: () {
              Navigator.pop(context);//الرجوع إلى الصفحة السابقة
            },
          ),
          title: Center(
            child: Image.asset(
              'assets/jisserLogo.jpeg', // شعار التطبيق
              width: 40,
              height: 40,
            ),
          ),
          actions: [SizedBox(width: 48)], // لتوازن العناصر في الشريط العلوي
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // محاذاة من اليمين
            children: [
              // صورة ومعلومات الطبيب
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(widget.specialist.imageUrl),
                  ),
                  SizedBox(width: 16), // مسافة بين الصورة والنص
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.specialist.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF546E78),
                        ),
                      ),
                      SizedBox(height: 8), // مسافة بين النصوص
                      Text(
                        widget.specialist.specialty,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24), // مسافة بين الأقسام

              // معلومات إضافية
              InfoRow(
                icon: Icons.school,
                label: 'المؤهل العلمي',
                value: widget.specialist.qualification,
              ),
              InfoRow(
                icon: Icons.history,
                label: 'الخبرة',
                value: widget.specialist.yearsOfExperience,
              ),
              InfoRow(
                icon: Icons.menu_book,
                label: 'تقديم الجلسات',
                value: 'كتابية',
              ),
              SizedBox(height: 24), // مسافة بين الأقسام

              // وقت الجلسة
              Text(
                'وقت الجلسة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.specialist.sessionTimes.map((time) {// المرور على كل وقت متاح في قائمة الجلسات
                  return buildRadioButton(time,// تمرير الوقت الحالي ليتم عرضه على زر الاختيار
                      _selectedTime!, (value) {
                    setState(() {
                      _selectedTime = value!;// تحديث الوقت المختار عند التغيير
                    });
                  });
                }).toList(),
              ),

              SizedBox(height: 24), // مسافة بين الأقسام

              // مدة الجلسة
              Text(
                'مدة الجلسة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  widget.specialist.sessionDurations.map((duration) {
                  return buildRadioButton(duration, _selectedDuration, (value) {
                    setState(() {
                      _selectedDuration = value!;
                    });
                  });
                }).toList(),
              ),

              SizedBox(height: 24), // مسافة بين الأقسام

              // زر الحجز
              Center(
                child: ElevatedButton(
                  onPressed: () async{
                    // TODO: Show payment dialog or navigate to payment screen
                    await paymentSheetInitialization(
                      amount.round().toString(),
                        "aed"
                    );
                    // Show payment sheet and wait for confirmation
                    await showPaymentSheet();

                    // If payment is successful, create the session
                    // Create the session
                    Sessions newSession = Sessions(
                      sessionId: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
                      specialistId: widget.specialist.id,
                      userId: "1", // Replace with logged-in user ID
                      sessionDate: DateTime.now().toString().split(" ")[0], // Example date
                      sessionTime: _selectedTime!,
                      duration: _selectedDuration!,
                      active: true,// Setting active to true when booked
                    );
                    // Add to sessions list
                    setState(() {
                      sessionsList.add(newSession);
                    });
                    // Show confirmation message
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم حجز الجلسة بنجاح!'))
                    );
                    // Navigate back
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // زوايا مستديرة
                    ),
                  ),
                  child: Text(
                    'حجز الجلسة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// دالة لإنشاء زر اختيار
  Widget buildRadioButton(
      String text, String? groupValue, Function(String?) onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: text,
          groupValue: groupValue, // القيمة الحالية للمجموعة
          onChanged: onChanged, // الإجراء عند التغيير
        ),
        Text(text), // النص بجانب زر الاختيار
      ],
    );
  }
}

// ويدجت مخصصة لعرض معلومات الطبيب
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
      padding: const EdgeInsets.symmetric(vertical: 8.0), // حواف عمودية
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          SizedBox(width: 8),
          Text('$label: ', // النص الرئيسي
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          Expanded(
            child: Text(value, // النص المرافق
                style: TextStyle(
                  color: Colors.grey[700],
                )),
          ),
        ],
      ),
    );
  }
}
