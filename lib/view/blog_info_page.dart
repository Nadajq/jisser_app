import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // تشغيل التطبيق الرئيسي
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شريط التصحيح
      home: AutismInfoPage(), // تعيين الصفحة الرئيسية
    );
  }
}

class AutismInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // تعيين لون الخلفية
        elevation: 1, // تعيين ارتفاع الظل
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue), // زر الرجوع
          onPressed: () {}, // تنفيذ عند الضغط
        ),
        centerTitle: true, // توسيط العنوان
        title: Image.asset('assets/icon.png', height: 40), // إضافة صورة أيقونة
      ),
      body: Container(
        padding: EdgeInsets.all(16), // إضافة هوامش داخلية
        decoration: BoxDecoration(
          color: Colors.blue.shade100, // تعيين لون الخلفية
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // إضافة حواف دائرية
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر إلى اليسار
            children: [
              Text(
                'ماهو اضطراب طيف التوحد؟', // عنوان رئيسي
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10), // إضافة مسافة بين العناصر
              Text(
                'اضطراب طيف التوحد عبارة عن حالة ترتبط بنمو الدماغ وتؤثر على كيفية تفسير الشخص للأخرين والتعامل معهم على المستوى الاجتماعي...'
                ' مما يتسبب في حدوث مشكلات في التفاعل والتواصل الاجتماعي. كما يتضمن الاضطراب أنماطًا سلوكية متكررة ومقيدة.\n\n'
                'يتضمن اضطراب طيف التوحد حالات كانت تُعتبر منفصلة في السابق، مثل التوحد، متلازمة أسبرجر، والاضطراب التحللي الطفولي، واضطراب النمو المتفشي غير المحدد، والتي تم دمجها الآن في اضطراب طيف التوحد.\n\n'
                'يبدأ اضطراب طيف التوحد في الطفولة المبكرة، ويتسبب في مشكلات على مستوى الأداء الاجتماعي سواء في المدرسة أو العمل. غالبًا تظهر العلامات المبكرة في عمر عامين أو أكثر.\n\n'
                'لا يوجد علاج حاليًا لاضطراب طيف التوحد، ولكن العلاج المبكر المكثف يمكن أن يحدث فارقًا كبيرًا في حياة الأطفال المصابين.',
                style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5), // تنسيق النص
              ),
            ],
          ),
        ),
      ),
    );
  }
}
