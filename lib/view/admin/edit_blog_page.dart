import 'package:flutter/material.dart';

import '../../model/blogs_model.dart';



// تعريف كلاس شاشة تعديل المدونة
class EditBlogPage extends StatefulWidget {
  final Blogs blog; // Pass the blog object to edit
  const EditBlogPage({Key? key, required this.blog}) : super(key: key);

  @override
  State<EditBlogPage> createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  late TextEditingController _titleController;  // متحكم لحقل عنوان المدونة
  late TextEditingController _dateController;   // متحكم لحقل تاريخ النشر
  late TextEditingController _contentController; // متحكم لحقل محتوى المدونة
  DateTime? _selectedDate;  // متغير لتخزين التاريخ المحدد من قبل المستخدم، ويكون فارغًا في البداية

  @override
  void initState() {
    super.initState();

    // تهيئة متحكمات النصوص بالقيم الحالية للمدونة
    _titleController = TextEditingController(text: widget.blog.title); // تعيين عنوان المدونة الحالي
    _dateController = TextEditingController(text: widget.blog.publishDate); // تعيين تاريخ النشر الحالي
    _contentController = TextEditingController(text: widget.blog.content); // تعيين محتوى المدونة الحالي
  }

  @override
  void dispose() {
    // تحرير الذاكرة عند إزالة الصفحة لمنع استهلاك غير ضروري للموارد
    _titleController.dispose();
    _dateController.dispose();
    _contentController.dispose();
    super.dispose();
  }

// دالة لفتح منتقي التاريخ وتمكين المستخدم من اختيار تاريخ النشر
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // عرض اليوم الحالي بشكل افتراضي إذا لم يتم اختيار تاريخ سابق
      firstDate: DateTime(2000), // أقدم تاريخ يمكن اختياره
      lastDate: DateTime(2100), // أحدث تاريخ يمكن اختياره
    );

    if (pickedDate != null) { // إذا اختار المستخدم تاريخًا جديدًا
      setState(() {
        _selectedDate = pickedDate; // حفظ التاريخ المحدد
        _dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}"; // تحديث النص الظاهر في الحقل
      });
    }
  }

// دالة لحفظ التعديلات التي قام بها المستخدم على بيانات المدونة
  void _updateBlog() {
    setState(() {
      widget.blog.title = _titleController.text; // تحديث العنوان الجديد
      widget.blog.publishDate = _dateController.text; // تحديث تاريخ النشر الجديد
      widget.blog.content = _contentController.text; // تحديث المحتوى الجديد
    });

    Navigator.pop(context, widget.blog); // إرجاع المدونة بعد التحديث إلى الشاشة السابقة
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                        controller: _titleController,// يربط حقل إدخال العنوان بالمتحكم، مما يسمح بقراءة وتحديث نص العنوان بسهولة
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
                        controller: _dateController,// يربط حقل إدخال تاريخ النشر بالمتحكم، مما يمكننا من عرض التاريخ المختار وتحديثه عند التعديل
                        textAlign: TextAlign.right,
                        readOnly: true, // جعل الحقل غير قابل للكتابة مباشرة
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_today, // أيقونة التاريخ
                              color: Colors.indigo[900], // يمكنك تغيير اللون حسب الحاجة
                              size: 24, // تغيير الحجم حسب الحاجة
                            ),
                            onPressed: _pickDate,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode()); // إخفاء لوحة المفاتيح
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
                  controller: _contentController,// يربط حقل إدخال المحتوى بالمتحكم، مما يتيح إدخال نص المحتوى وعرضه وتعديله
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
                    onPressed: _updateBlog,
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
      ),
    );
  }
}
