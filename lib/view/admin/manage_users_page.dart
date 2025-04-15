import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/view/admin/add_admin.dart';
import 'package:jisser_app/view/admin/admin_login_page.dart';
import 'package:jisser_app/view/admin/manage_blog_page.dart';
import 'package:jisser_app/view/admin/manage_sessions_page.dart';
import 'package:jisser_app/view/admin/manage_specialist_page.dart';
import 'package:jisser_app/view/user_login_page.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  _ManageUsersPage createState() => _ManageUsersPage();
}

class _ManageUsersPage extends State<ManageUsersPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredUsers = [];
  List<Map<String, dynamic>> _allUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await Supabase.instance.client.from('userrs').select();
      setState(() {
        _allUsers = List<Map<String, dynamic>>.from(response);
        _filteredUsers = List.from(_allUsers);
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 1:
        return const ManageSpecialistPage();
      case 2:
        return const ManageSessionsPage();
      case 3:
        return const ManageBlogPage();
      default:
        return _userManagementPage();
    }
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        final name = user['name'].toString().toLowerCase();
        final email = user['email'].toString().toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) || email.contains(searchLower);
      }).toList();
    });
  }

  Future<void> _deleteUser(Map<String, dynamic> user) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).confirm_delete),
        content: Text(S.of(context).are_you_sure_you_want_to_delete_this_user),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              try {
                final response = await Supabase.instance.client
                    .from('userrs')
                    .delete()
                    .eq('id', user['id']);
                setState(() {
                  _allUsers.removeWhere((u) => u['id'] == user['id']);
                  _filteredUsers = List.from(_allUsers);
                });
                setState(() {});
                Navigator.pop(context);
                CustomSnackBar.snackBarwidget(
                    context: context,
                    color: Colors.green,
                    text: S.of(context).deteled_successfully);
              } catch (e) {
                print('Error deleting user: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: $e")),
                );
              }
            },
            child: Text(S.of(context).delete,
                style: const TextStyle(color: Colors.red)),
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/jisserLogo.jpeg",
                height: 30,
              )
            ],
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(7),
              child: PopupMenuButton<int>(
                icon: const Icon(Icons.menu, color: Colors.blueAccent),
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                itemBuilder: (context) => [

                  PopupMenuItem<int>(
                    value: 1,
                    child: ListTile(
                      title: Row(
                        children: [
                          const Icon(Icons.language,
                              color: Colors.blueAccent, size: 20),
                          const SizedBox(width: 5),
                          Text(S.of(context).change_language,
                              style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      onTap: () {
                        BlocProvider.of<ChangeLangaugeCubit>(context)
                            .changeLangauge();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: ListTile(
                      title: Row(
                        children: [
                          const Icon(Icons.add,
                              color: Color(0xfff90606), size: 20),
                          const SizedBox(width: 5),
                          Text(S.of(context).add_admin,
                              style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddAdmin()));
                      },
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: ListTile(
                      title: Row(
                        children: [
                          const Icon(Icons.exit_to_app,
                              color: Color(0xfff90606), size: 20),
                          const SizedBox(width: 5),
                          Text(S.of(context).logout,
                              style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminLoginPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          elevation: 0.0,
        ),
        body: _getSelectedPage(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const Icon(Icons.groups),
                  Text(S.of(context).users),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const Icon(Icons.medical_services),
                  Text(S.of(context).specialists),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const Icon(Icons.group),
                  Text(S.of(context).sessions),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const Icon(Icons.menu_book),
                  Text(S.of(context).blogs),
                ],
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _userManagementPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).manage_users,
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
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    _filterUsers(value);
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
            Container(
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
                dataTextStyle: const TextStyle(fontSize: 11),
                columns: [
                  DataColumn(label: Text(S.of(context).user_name)),
                  DataColumn(label: Text(S.of(context).email)),
                  DataColumn(label: Text(S.of(context).delete)),
                ],
                rows: _buildUserRows(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildUserRows() {
    return _filteredUsers.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user['name'])),
          DataCell(Text(user['email'])),
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 18),
              onPressed: () => _deleteUser(user),
            ),
          ),
        ],
      );
    }).toList();
  }
}
