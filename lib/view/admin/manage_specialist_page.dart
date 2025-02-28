import 'package:flutter/material.dart';
import 'package:jisser_app/model/specialist_model.dart';

import 'edit_specialist_page.dart';

class ManageSpecialistPage extends StatefulWidget {
  const ManageSpecialistPage({super.key});

  @override
  State<ManageSpecialistPage> createState() => _ManageSpecialistPageState();
}

class _ManageSpecialistPageState extends State<ManageSpecialistPage> {
  TextEditingController _searchController = TextEditingController();
  List<Specialist> _filteredSpecialists = [];


  @override
  void initState() {
    super.initState();
    _filteredSpecialists = specialistsInfo; // Initially, show all specialists
  }

  void _filterSpecialists(String query) {
    setState(() {
      _filteredSpecialists = specialistsInfo.where((specialist) {
        final name = specialist.name.toLowerCase();
        final qualification = specialist.qualification.toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) ||
            qualification.contains(searchLower);
      }).toList();
    });
  }
  void _deleteSpecialists(Specialist specialist) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد أنك تريد حذف هذا الاخصائي؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                specialistsInfo.remove(specialist);
                _filteredSpecialists = List.from(specialistsInfo);
              });
              Navigator.pop(context);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child:
              Text(
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
                        DataCell(Text(specialist.name)),
                        DataCell(Text(specialist.id)),
                        DataCell(Text(specialist.qualification)),
                        DataCell(Icon(
                          specialist.active ? Icons.check_circle : Icons.cancel,  // Green check or red cross
                          color: specialist.active ? Colors.green : Colors.red,  // Green for active, red for inactive
                        ),),
                        DataCell(IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () async {
                            // Navigate to the edit page and pass the current specialist
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSpecialistPage(
                                  specialist: specialist, // Pass the current specialist data
                                ),
                              ),
                            );
                          },
                        )),
                        DataCell(IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSpecialists(specialist),
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
}
