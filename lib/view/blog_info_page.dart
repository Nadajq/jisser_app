import 'package:flutter/material.dart';
import 'package:jisser_app/model/blogs_model.dart';

class BlogInfoPage extends StatelessWidget {
  final Blogs blogs;

  const BlogInfoPage({super.key, required this.blogs});
  @override
  Widget build(BuildContext context) {

    return Directionality(
      // لضبط اتجاه النص والعناصر من اليمين إلى اليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
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
          actions: const [ SizedBox(width: 48)], // لتوازن العناصر في الشريط العلوي
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40), // مسافة بين AppBar والمحتوى

              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height, // جعل الحاوية بحجم الشاشة
                ),
                padding: const EdgeInsets.all(16), // إضافة هوامش داخلية
                decoration: BoxDecoration(
                  color: blogs.bgcolor, // تعيين لون الخلفية
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40)), // إضافة حواف دائرية
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر إلى اليسار
                    children: [
                      Text(
                        blogs.title, // عنوان رئيسي
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10), // إضافة مسافة بين العناصر
                      Text( blogs.content,
                        style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5), // تنسيق النص
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
