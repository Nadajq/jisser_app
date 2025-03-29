import 'package:flutter/material.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edit_specialist_page.dart';

class ManageSpecialistPage extends StatefulWidget {
  const ManageSpecialistPage({super.key});

  @override
  State<ManageSpecialistPage> createState() => _ManageSpecialistPageState();
}

class _ManageSpecialistPageState extends State<ManageSpecialistPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _searchController = TextEditingController();
  List<Specialist> _filteredSpecialists = [];
  List<Specialist> specialistsInfo = [];
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _fetchSpecialists();
  }

  Future<void> _fetchSpecialists() async {
    final response = await supabase.from('specialists').select('*');
    setState(() {
      specialistsInfo = response.map<Specialist>((data) => Specialist(
        id: data['id'],
        name: data['name'],
        imageUrl: data['image_url'],
        pdfUrl: data['pdf_url'],
        email: data['email'],
        specialty: data['specialty'],
        qualification: data['qualification'],
        yearsOfExperience: data['years_of_experience'],
        active: data['active'],
        rating: data['rating'],
        sessionDurations: data['session_duration'],
        sessionTimes: data['session_times'],
        date: data['date'],
      )).toList();
      _filteredSpecialists = specialistsInfo;
    });
  }

  void _filterSpecialists(String query) {
    setState(() {
      _filteredSpecialists = specialistsInfo.where((specialist) {
        final name = specialist.name.toLowerCase();
        final qualification = specialist.qualification.toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) || qualification.contains(searchLower);
      }).toList();
    });
  }

  void _deleteSpecialist(Specialist specialist) async {
    await supabase.from('specialists').delete().match({'id': specialist.id});
    _fetchSpecialists();
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
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).manage_specialists,
                style:const TextStyle(
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
                    hintText: S.of(context).search,
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
                    columns:  [
                      DataColumn(label: Text(S.of(context).specialist_name)),
                      DataColumn(label: Text(S.of(context).years_of_experience)),
                      // DataColumn(label: Text("التخصص")),
                      // DataColumn(label: Text('المؤهل')),
                      DataColumn(label: Text(S.of(context).status)),
                      DataColumn(label: Text(S.of(context).edit)),
                      DataColumn(label: Text(S.of(context).delete)),
                    ],
                    rows: _filteredSpecialists.map((specialist) {
                      return DataRow(cells: [
                        DataCell(Text(specialist.name)),
                        DataCell(Text(specialist.yearsOfExperience)),
                        // DataCell(Text(specialist.specialty)),
                        // DataCell(Text(specialist.qualification)),
                        DataCell(Icon(
                          specialist.active == true ? Icons.check_circle : Icons.cancel,
                          color: specialist.active == true ? Colors.green : Colors.red,
                        )),
                        DataCell(IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSpecialistPage(
                                  specialist: specialist,
                                ),
                              ),
                            );
                            _fetchSpecialists(); // Refresh after returning from edit page
                          },
                        )),
                        DataCell(IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSpecialist(specialist),
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