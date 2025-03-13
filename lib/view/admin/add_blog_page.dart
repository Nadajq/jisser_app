import 'package:flutter/material.dart';

import '../../model/blogs_model.dart';



// تعريف كلاس شاشة إضافة المدونة
class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  // تعريف المتحكمات الخاصة بكل حقل إدخال
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _contentController;
  DateTime? _selectedDate; // متغير لتخزين التاريخ المحدد

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(); // تهيئة متحكم العنوان
    _dateController = TextEditingController(); // تهيئة متحكم التاريخ
    _contentController = TextEditingController(); // تهيئة متحكم المحتوى
  }

  @override
  void dispose() {
    // تنظيف المتحكمات عند التخلص من هذه الصفحة
    _titleController.dispose();
    _dateController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // دالة لاختيار التاريخ
  void _pickDate() async {
    // عرض اختيار التاريخ
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // التاريخ الأولي هو تاريخ اليوم
      firstDate: DateTime(2000), // أول تاريخ مسموح به
      lastDate: DateTime(2100), // آخر تاريخ مسموح به
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate; // تخزين التاريخ المحدد
        _dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}"; // عرض التاريخ في الحقل
      });
    }
  }

  // دالة لمعالجة نشر المدونة
  void _submitBlog() {
    // التأكد من ملء جميع الحقول
    if (_titleController.text.isNotEmpty && _selectedDate != null && _contentController.text.isNotEmpty) {
      Blogs newBlog = Blogs(
        id: '',
        title: _titleController.text, // استخدام نص العنوان
        publishDate: _dateController.text, // استخدام تاريخ النشر
        content: _contentController.text,  // استخدام نص المحتوى
      );

      // إضافة المدونة الجديدة إلى الموديل أو قاعدة البيانات


      Navigator.pop(context, newBlog); // العودة مع المدونة المضافة
    } else {
      // عرض رسالة خطأ إذا كان هناك حقل فارغ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول!')), // الرسالة التي تظهر في حالة عدم ملء الحقول
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFBFB), // لون الخلفية
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

          child: SingleChildScrollView(   // لجعل المحتوى قابلًا للتمرير
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
                        controller: _titleController, // ربط الحقل بمتحكم العنوان
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
                        controller: _dateController, // ربط الحقل بمتحكم التاريخ
                        textAlign: TextAlign.right,
                        readOnly: true, // جعل الحقل غير قابل للكتابة مباشرة
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today, // أيقونة اختيار التاريخ
                              color: Colors.indigo, // اللون المفضل للأيقونة
                            ),
                            onPressed: _pickDate, // عند الضغط على الأيقونة يتم اختيار التاريخ
                          ),
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

                // حقل إدخال محتوى المدونة
                const Text(
                  'المحتوى:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _contentController, // ربط الحقل بمتحكم المحتوى
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

                const SizedBox(height: 30),

                // زر نشر المدونة
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _submitBlog, // عند الضغط يتم نشر المدونة
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
