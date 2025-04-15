import 'package:flutter/material.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jisser_app/model/sessions_model.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';

class ManageSessionsPage extends StatefulWidget {
  const ManageSessionsPage({super.key});

  @override
  State<ManageSessionsPage> createState() => _ManageSessionsPageState();
}

class _ManageSessionsPageState extends State<ManageSessionsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Sessions> _filteredSessions = [];
  List<Sessions> _allSessions = []; 
  List<Specialist> specialistsInfo = []; 
  List<Users> usersList = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchData(); 
  }

  Future<void> _fetchData() async {
    try {
      final sessionsResponse = await Supabase.instance.client
          .from('sessions')
          .select()
          .order('created_at', ascending: false); 
      final specialistsResponse =
          await Supabase.instance.client.from('specialists').select();

      final usersResponse =
          await Supabase.instance.client.from('userrs').select();
      setState(() {
        _allSessions = sessionsResponse
            .map((session) => Sessions.fromJson(session))
            .toList();
        specialistsInfo = specialistsResponse
            .map((specialist) => Specialist.fromMap(specialist))
            .toList();
        usersList = usersResponse.map((user) => Users.fromJson(user)).toList();
        _filteredSessions = List.from(_allSessions); 
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  
  void _filterSessions(String query) {
    final searchLower = query.toLowerCase();
    setState(() {
      _filteredSessions = _allSessions.where((session) {
        final specialistName =
            session.getSpecialistName(specialistsInfo).toLowerCase();
        final userName = session.getUserName(usersList).toLowerCase();
        return specialistName.contains(searchLower) ||
            userName.contains(searchLower);
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
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).manage_sessions,
                style: const TextStyle(
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
                        hintText: S.of(context).search,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
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
                    columns:  [
                      DataColumn(label: Text(S.of(context).specialist_name)),
                      DataColumn(label: Text(S.of(context).user_name)),
                      DataColumn(label: Text(S.of(context).date)),
                      DataColumn(label: Text(S.of(context).time)),
                      DataColumn(label: Text(S.of(context).duration)),
                      DataColumn(label: Text(S.of(context).status)),
                    ],
                    rows: _filteredSessions.map((session) {
                      return DataRow(cells: [
                        DataCell(
                            Text(session.getSpecialistName(specialistsInfo))),
                        DataCell(Text(session.getUserName(usersList))),
                        DataCell(Text(session.sessionDate)),
                        DataCell(Text(session.sessionTime)),
                        DataCell(Text(session.duration)),
                        DataCell(
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: session.active ?  Colors.red:  Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              session.active ? Icons.close: Icons.check ,
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
