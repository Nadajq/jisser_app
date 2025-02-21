import 'package:flutter/material.dart';

class ManageBlogPage extends StatelessWidget {
  const ManageBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text('Manage blogs Page')),
    );
  }
}




/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إدارة المدونة', // عنوان التطبيق
      theme: ThemeData(
        primarySwatch: Colors.blue, // اللون الرئيسي للتطبيق
        fontFamily: 'NotoNaskhArabic', // تعيين خط التطبيق
      ),
      debugShowCheckedModeBanner: false, // إخفاء علامة "وضع المطور"
      home: const BlogManagementScreen(), // تحديد الشاشة الرئيسية للتطبيق
      locale: const Locale('ar', 'AE'), // تحديد اللغة الافتراضية إلى العربية
    );
  }
}

// كلاس يمثل التدوينات في المدونة
class BlogPost {
  final String title; // عنوان التدوينة
  final String date; // تاريخ نشر التدوينة

  const BlogPost({required this.title, required this.date}); // المُنشئ لاستقبال القيم
}

// الشاشة الرئيسية لإدارة المدونات
class BlogManagementScreen extends StatefulWidget {
  const BlogManagementScreen({super.key});

  @override
  _BlogManagementScreenState createState() => _BlogManagementScreenState();
}

class _BlogManagementScreenState extends State<BlogManagementScreen> {
  // قائمة تحتوي على التدوينات
  final List<BlogPost> blogPosts = [
    const BlogPost(title: 'فهم التوحد', date: '25-1-27'),
    const BlogPost(title: 'العلاج السلوكي للتوحد', date: '25-1-25'),
    const BlogPost(title: 'التوحد في المدارس', date: '25-1-29'),
    const BlogPost(title: 'التوحد والنظام الغذائي', date: '25-1-30'),
    const BlogPost(title: 'التوحد والمراهقة', date: '25-1-31'),
    const BlogPost(title: 'التوحد والتكنولوجيا', date: '25-2-1'),
    const BlogPost(title: 'التوحد واختلاف العلاقات', date: '25-2-2'),
    const BlogPost(title: 'أنماط السلوك في التوحد', date: '25-2-3'),
    const BlogPost(title: 'التوحد في البلوغ', date: '25-2-4'),
    const BlogPost(title: 'الاندماج الاجتماعي للتوحد', date: '25-2-5'),
    const BlogPost(title: 'دعم الأخصائيين للأطفال', date: '25-3-6'),
  ];

  int _selectedIndex = 0; // مؤشر العنصر المحدد في شريط التنقل السفلي

  // تحديث المؤشر عند النقر على أيقونة في شريط التنقل السفلي
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // جعل اتجاه النص من اليمين إلى اليسار
      child: Scaffold(
        backgroundColor: const Color(0xffe0f5fe), // تعيين لون خلفية الشاشة
        appBar: AppBar(
          backgroundColor: Colors.white, // لون شريط العنوان
          actions: [
            IconButton(
              icon: const Icon(Icons.email, color: Colors.blueAccent, size: 30),
              onPressed: () {}, // زر البريد الإلكتروني (لم يتم تحديد وظيفته بعد)
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.logout, color: Colors.red, size: 30),
            onPressed: () {}, // زر تسجيل الخروج (لم يتم تحديد وظيفته بعد)
          ),
          title: Center(
            child: Image.asset('images/logo.png', width: 50, height: 50), // عرض شعار التطبيق
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0), // إضافة هامش داخلي حول المحتوى
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // محاذاة العناصر في الوسط
            mainAxisAlignment: MainAxisAlignment.center, // توسيط العناصر عموديًا
            children: [
              const Text(
                "إدارة المدونة",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // تنسيق عنوان الصفحة
              ),
              const SizedBox(height: 8), // إضافة مسافة بين العناصر
              SizedBox(
                width: 300, // تحديد عرض مربع البحث
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'بحث...', // نص توضيحي داخل مربع البحث
                    suffixIcon: const Icon(Icons.search), // أيقونة البحث
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // تدوير زوايا المربع
                    ),
                    filled: true,
                    fillColor: Colors.white, // خلفية بيضاء لمربع البحث
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity, // عرض كامل للعنصر
                    margin: const EdgeInsets.symmetric(horizontal: 20), // إضافة هامش جانبي
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15), // تدوير الزوايا
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, // إضافة ظل خفيف
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical, // السماح بالتمرير العمودي
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal, // السماح بالتمرير الأفقي
                              child: DataTable(
                                columnSpacing: 22, // المسافة بين الأعمدة
                                dataRowMinHeight: 40,
                                dataRowMaxHeight: 45,
                                headingRowHeight: 45, // ارتفاع صف العناوين
                                headingRowColor: MaterialStateProperty.all(
                                  const Color(0xffe0f5fe), // لون خلفية صف العناوين
                                ),
                                columns: const [
                                  DataColumn(label: _HeaderText('العنوان')),
                                  DataColumn(label: _HeaderText('تاريخ النشر')),
                                  DataColumn(label: _HeaderText('تعديل')),
                                  DataColumn(label: _HeaderText('حذف')),
                                  DataColumn(label: _HeaderText('عرض')),
                                ],
                                rows: List<DataRow>.generate(
                                  blogPosts.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(_buildTitleCell(blogPosts[index].title)), // خلية العنوان
                                      DataCell(_buildDateCell(blogPosts[index].date)), // خلية التاريخ
                                      DataCell(_buildImageActionButton('images/edit.png')), // زر تعديل
                                      DataCell(_buildImageActionButton('images/delete.png')), // زر حذف
                                      DataCell(_buildImageActionButton('images/view.png')), // زر عرض
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('images/modona.png', width: 30, height: 30),
              label: 'المدونة',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/session.png', width: 30, height: 30),
              label: 'الجلسات',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/users.png', width: 30, height: 30),
              label: 'الأخصائيين',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/users.png', width: 30, height: 30),
              label: 'المستخدمين',
            ),
          ],
          currentIndex: _selectedIndex, // العنصر المحدد حاليًا
          selectedItemColor: Colors.blueAccent, // لون العنصر النشط
          unselectedItemColor: Colors.grey, // لون العناصر غير النشطة
          onTap: _onItemTapped, // استدعاء الدالة عند النقر
        ),
      ),
    );
  }*/
