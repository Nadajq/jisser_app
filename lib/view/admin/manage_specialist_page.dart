import 'package:flutter/material.dart';

class ManageSpecialistPage extends StatefulWidget {
  @override
  _ManageSpecialistPageState createState() => _ManageSpecialistPageState(); // إنشاء حالة الصفحة
}

class _ManageSpecialistPageState extends State<ManageSpecialistPage> {
  // قائمة تحتوي على بيانات الأخصائيين مثل الاسم، المعرف، الهاتف، والحالة
  List<Map<String, String>> specialists = [
    {'name': 'د. أحمد', 'id': 'A1b2C34d', 'phone': 'كالوريوس', 'status': 'نشط'},
    {'name': 'د. أحمد', 'id': 'XyZ9kLNm', 'phone': 'دكتوراه', 'status': 'نشط'},
    {'name': 'د. أحمد', 'id': 'qR5TsUv8', 'phone': 'ماجستير', 'status': 'معطل'},
    {'name': 'د. أحمد', 'id': 'mNQr9rS1', 'phone': 'ماجستير', 'status': 'نشط'},
  ];

  // دالة لحذف الأخصائي من القائمة
  void _deleteSpecialist(int index) {
    setState(() {
      specialists.removeAt(index);
    });
  }

  // دالة لتغيير حالة الأخصائي بين نشط ومعطل
  void _toggleStatus(int index) {
    setState(() {
      specialists[index]['status'] =
          specialists[index]['status'] == 'نشط' ? 'معطل' : 'نشط';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1, // إضافة ارتفاع طفيف لشريط التطبيق
        leading: Icon(Icons.email, color: Colors.blue), // أيقونة البريد
        actions: [
          IconButton(
            icon: Icon(Icons.folder, color: Colors.red),
            onPressed: () {
              // إضافة حدث الخروج
              Navigator.pop(context);
            },
          ),
        ], // أيقونة الإشعارات
        title: Center(child: Text('إدارة الأخصائيين', style: TextStyle(color: Colors.black)));
      ),
      body: Column(
        children: [
          // حقل البحث لتصفية قائمة الأخصائيين
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'بحث',
                prefixIcon: Icon(Icons.search), // أيقونة البحث
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          // عرض قائمة الأخصائيين
          Expanded(
            child: ListView.builder(
              itemCount: specialists.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(specialists[index]['name']!), // عرض اسم الأخصائي
                    subtitle: Text('ID: ${specialists[index]['id']} - ${specialists[index]['phone']}'), // عرض المعرف والهاتف
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // زر تغيير حالة الأخصائي
                        IconButton(
                          icon: Icon(
                            specialists[index]['status'] == 'نشط' ? Icons.check_circle : Icons.cancel,
                            color: specialists[index]['status'] == 'نشط' ? Colors.green : Colors.red,
                          ),
                          onPressed: () => _toggleStatus(index),
                        ),
                        // زر تعديل الأخصائي
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {},
                        ),
                        // زر حذف الأخصائي
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSpecialist(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'المستخدمين'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الأخصائيين'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'الجلسات'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'المدونة'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
