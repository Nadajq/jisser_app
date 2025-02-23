import 'package:flutter/material.dart';
import 'package:jisser_app/model/sessions_model.dart';


class ManageSessionsPage extends StatefulWidget {
  const ManageSessionsPage({super.key});

  @override
  State<ManageSessionsPage> createState() => _ManageSessionsPageState();
}

class _ManageSessionsPageState extends State<ManageSessionsPage> {
  TextEditingController _searchController = TextEditingController();
  List<Sessions> _filteredSessions = [];

  @override
  void initState() {
    super.initState();
    _filteredSessions = sessionsList; // تأكد من أن sessionsList معرّفة ومستوردة
  }

  void _filterSessions(String query) {
    setState(() {
      _filteredSessions = sessionsList.where((session) {
        final name = session.specialistname.toLowerCase();
        final userName = session.userName.toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) || userName.contains(searchLower);
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'إدارة الجلسات',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterSessions,
                      decoration: InputDecoration(
                        hintText: 'بحث',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
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
                      DataColumn(label: Text('الأخصائي')),
                      DataColumn(label: Text('المستخدم')),
                      DataColumn(label: Text('التاريخ')),
                      DataColumn(label: Text('الوقت')),
                      DataColumn(label: Text('المدة')),
                      DataColumn(label: Text('الحالة')),
                    ],
                    rows: _filteredSessions.map((session) {
                      return DataRow(cells: [
                        DataCell(Text(session.specialistname)),
                        DataCell(Text(session.userName)),
                        DataCell(Text(session.sessionDate)),
                        DataCell(Text(session.sessionTime)),
                        DataCell(Text(session.duration)),
                        DataCell(
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: session.active ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              session.active ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),

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
