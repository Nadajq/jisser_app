import 'package:flutter/material.dart';

import 'edit_specialist_page.dart';

class ManageSpecialistPage extends StatefulWidget {
  @override
  State<ManageSpecialistPage> createState() => _ManageSpecialistPageState();
}

class _ManageSpecialistPageState extends State<ManageSpecialistPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> specialists = [
    {'name': 'د.أحمد', 'id': 'A1b2C3d4', 'المؤهل': 'بكالوريس', 'active': true},
    {'name': 'د.ماجد', 'id': 'XyZ9kLmN', 'المؤهل': 'دكتوراه', 'active': true},
    {'name': 'أ.سارة', 'id': 'qR5sTuV8', 'المؤهل': 'دكتوراه', 'active': false},
    {'name': 'أ.مريم', 'id': 'mNpQrSt1', 'المؤهل': 'ماجستير', 'active': false},
    {'name': 'د.نوره', 'id': 'wX3Yz2A4', 'المؤهل': 'دكتوراه', 'active': false},
    {'name': 'د.خالد', 'id': 'B2C3D4E5', 'المؤهل': 'بكالوريس', 'active': false},
    {'name': 'د.رحاب', 'id': 'F6G7H8J9', 'المؤهل': 'ماجستير', 'active': true},
    {'name': 'د.علي', 'id': 'JkLmNoP2', 'المؤهل': 'ماجستير', 'active': true},
    {'name': 'أ.محمد', 'id': 'T5UuWx4Y', 'المؤهل': 'دكتوراه', 'active': true},
    {
      'name': 'د. عبدالله',
      'id': 'Z2A1B0C9',
      'المؤهل': 'بكالوريس',
      'active': false
    },
    {'name': 'د.ماجد', 'id': '1234EfGh', 'المؤهل': 'ماجستير', 'active': true},
  ];

  List<Map<String, dynamic>> _filteredSpecialists = [];

  @override
  void initState() {
    super.initState();
    _filteredSpecialists = specialists; // Initially, show all specialists
  }

  void _filterSpecialists(String query) {
    setState(() {
      _filteredSpecialists = specialists.where((specialist) {
        final name = specialist['name']!.toLowerCase();
        final qualification = specialist['المؤهل']!.toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) ||
            qualification.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xfff3f7f9),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  controller: _searchController,
                  onChanged: (value) {
                    _filterSpecialists(value);
                  },
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
            Expanded(
              child: SingleChildScrollView(
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
                    dataRowHeight: 45,
                    headingRowHeight: 40,
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
                      DataColumn(label: Text('id')),
                      DataColumn(label: Text('المؤهل')),
                      DataColumn(label: Text('الحالة')),
                      DataColumn(label: Text('تعديل')),
                      DataColumn(label: Text('حذف')),
                    ],
                    rows: _filteredSpecialists.map((specialist) {
                      return DataRow(cells: [
                        DataCell(Text(specialist['name'])),
                        DataCell(Text(specialist['id'])),
                        DataCell(Text(specialist['المؤهل'])),
                        DataCell(Icon(
                          specialist['active'] ? Icons.check_circle : Icons.cancel,  // Green check or red cross
                          color: specialist['active'] ? Colors.green : Colors.red,  // Green for active, red for inactive
                        ),),
                        DataCell(IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () async {
                            // Navigate to the edit page and pass the current specialist
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSpecialistPage(
                                  //specialist: specialist, // Pass the current specialist data
                                ),
                              ),
                            );
                          },
                        )),
                        DataCell(IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              specialists.remove(specialist);
                            });
                          },
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  void _editSpecialist(Map<String, dynamic> specialist) {
    TextEditingController nameController =
        TextEditingController(text: specialist['name']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تعديل الأخصائي'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم الأخصائي'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  specialist['name'] = nameController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}
