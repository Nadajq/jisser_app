import 'package:flutter/material.dart';



// تعريف كلاس شاشة تعديل المدونة
class EditBlogPage extends StatelessWidget {
  const EditBlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FA), // لون الخلفية
      appBar: AppBar(
        backgroundColor: Colors.white,
        // لون شريط العنوان
        elevation: 0,
        // إزالة الظل من شريط العنوان
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
          'assets/jisserLogo.jpeg', // Logo in the center
          width: 40,
          height: 40,
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // إضافة هوامش جانبية
        child: SingleChildScrollView(
          // لجعل المحتوى قابلًا للتمرير
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // مسافة علوية
              const Text(
                'تعديل المدونة',
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
                        FocusScope.of(context)
                            .requestFocus(FocusNode()); // إخفاء لوحة المفاتيح

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
                maxLines: 11, // السماح بكتابة عدة أسطر
                decoration: InputDecoration(
                  hintText:
                      "اضطراب طيف التوحد عبارة عن حالة ترتبط بنمو الدماغ...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // زر تعديل المدونة
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // هنا يتم تنفيذ عملية تعديل المدونة
                  },
                  child: const Text(
                    'تعديل',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30), // مسافة سفلية
            ],
          ),
        ),
      ),
    );
  }
}
