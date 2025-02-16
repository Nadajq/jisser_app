import 'package:flutter/material.dart';

class manageSpecialistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xfff3f7f9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            'assets/jisserLogo.jpeg',
            width: 40,
            height: 40,
          ),
          centerTitle: true,
          actions: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.email,
                color: Colors.blue,
              ),
            ),
          ],
          leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.logout_sharp,
              color: Colors.red,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'إدارة الأخصائيين',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'بحث',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffeae9e9)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DataTable(
                    columnSpacing: 18.0,
                    dataRowHeight: 35,
                    headingRowHeight: 35,
                    headingTextStyle: const TextStyle(
                      color: Color(0xff2b2c2c),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    dataTextStyle: const TextStyle(
                      fontSize: 11,
                    ),
                    columns: const [
                      DataColumn(label: Text('اسم الأخصائي')),
                      DataColumn(label: Text('المعُرف')),
                      DataColumn(label: Text('البريد الإلكتروني')),
                      DataColumn(label: Text('حذف')),
                    ],
                    rows: _buildSpecialistRows(),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.groups),
                  Text('المستخدمين'),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.medical_services),
                  Text('الأخصائيين'),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.group),
                  Text('الجلسات'),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.menu_book),
                  Text('المدونة'),
                ],
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildSpecialistRows() {
    final specialists = [
      {'name': 'د. سارة', 'id': 'A1b2C3d4', 'email': 'jd@gmail.com'},
      {'name': 'د. ريم', 'id': 'XyZ9kLmN', 'email': 'sc@email.com'},
      {'name': 'د. محمد', 'id': 'qR5sTuV8', 'email': 'ms@outlook.com'},
      {'name': 'د. مها', 'id': 'mNpQrSt1', 'email': 'ew@gmail.com'},
      {'name': 'د. عبدالله', 'id': 'wX3Yz24', 'email': 'lj@gmail.com'},
      {'name': 'د. عبدالعزيز', 'id': 'B2C3D4E5', 'email': 'lb@yahoo.com'},
      {'name': 'د. عبير', 'id': 'F6G7H8J9', 'email': 'ce@outlook.com'},
      {'name': 'د. يوسف', 'id': 'JkLmNoP2', 'email': 'er@yahoo.com'},
      {'name': 'د. جنى', 'id': 'T5UuWx4Y', 'email': 'pr@gmail.com'},
      {'name': 'د. احمد', 'id': 'Z2A1B0C9', 'email': 'kc@email.com'},
    ];

    return specialists
        .map(
          (specialist) => DataRow(cells: [
        DataCell(Text(specialist['name']!)),
        DataCell(Text(specialist['id']!)),
        DataCell(Text(specialist['email']!)),
        const DataCell(Icon(Icons.delete, color: Colors.red, size: 18)),
      ]),
    )
        .toList();
  }
}

