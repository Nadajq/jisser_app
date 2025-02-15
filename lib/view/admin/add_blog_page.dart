import 'package:flutter/material.dart';

// الدالة الرئيسية لتشغيل التطبيق
void main() {
  runApp(const MyApp());
}

// تعريف الكلاس الرئيسي للتطبيق
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شريط وضع التطوير
      home: const Directionality(
        textDirection: TextDirection.rtl, // جعل اتجاه النص من اليمين إلى اليسار
        child: AddBlogScreen(), // عرض شاشة إضافة المدونة
      ),
    );
  }
}

// تعريف كلاس شاشة إضافة المدونة
class AddBlogScreen extends StatelessWidget {
  const AddBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FA), // لون الخلفية
      appBar: AppBar(
        backgroundColor: Colors.white, // لون شريط العنوان
        elevation: 0, // إزالة الظل من شريط العنوان
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context); // الرجوع إلى الشاشة السابقة عند الضغط
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'images/logo.jpg', // شعار التطبيق
          height: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), // إضافة هوامش جانبية
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // مسافة علوية
            const Text(
              'إضافة مدونة',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30), // مسافة بين العناصر

            // حقل إدخال عنوان المدونة
            Row(
              children: [
                const Text(
                  'العنوان:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // حقل إدخال تاريخ النشر
            Row(
              children: [
                const Text(
                  'تاريخ النشر:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    readOnly: true, // جعل الحقل غير قابل للكتابة مباشرة
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'images/date.jpeg', // أيقونة التاريخ
                          width: 24,
                          height: 24,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode()); // إخفاء لوحة المفاتيح

                      // إظهار التقويم لاختيار التاريخ
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        // يمكن تخزين التاريخ المختار هنا
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // حقل إدخال محتوى المدونة
            const Text(
              'المحتوى:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.right,
              maxLines: 6, // السماح بكتابة 6 أسطر
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const Spacer(), // دفع الزر إلى الأسفل

            // زر نشر المدونة
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // هنا يتم تنفيذ عملية نشر المدونة
                },
                child: const Text(
                  'نشر',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100), // مسافة سفلية
          ],
        ),
      ),
    );
  }
