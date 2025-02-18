import 'package:flutter/material.dart';
import 'package:jisser_app/view/admin/edit_blog_page.dart';
import 'package:jisser_app/view/admin/manage_blog_page.dart';
import 'package:jisser_app/view/admin/manage_sessions_page.dart';
import 'package:jisser_app/view/admin/manage_specialist_page.dart';

import 'add_blog_page.dart';

// Define the manageUsersPage widget as a StatefulWidget
class ManageUsersPage extends StatefulWidget {
  @override
  _ManageUsersPage createState() => _ManageUsersPage();
}

// Define the state of the manageUsersPage widget
class _ManageUsersPage extends State<ManageUsersPage> {
  int _selectedIndex = 0; // Track selected tab index
  // Handle bottom navigation taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Different pages based on the selected index
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 1:
        return ManageSpecialistPage(); // Navigate to specialists page
      case 2:
        return ManageSessionsPage(); // Navigate to sessions page
      case 3:
        return ManageBlogPage(); // Navigate to blog page
      default:
        return _userManagementPage(); // Default to user management page
    }
  }

  // Method to filter users based on the search query
  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = users.where((user) {
        // Convert name and email to lowercase for case-insensitive matching
        final name = user['name']!.toLowerCase();
        final email = user['email']!.toLowerCase();
        final searchLower = query.toLowerCase();
        // Return true if the name or email contains the search query
        return name.contains(searchLower) || email.contains(searchLower);
      }).toList();
    });
  }

  // Method to delete a user by their ID
  void _deleteUser(String id) {
    setState(() {
      // Remove the user from the main list and the filtered list
      users.removeWhere((user) => user['id'] == id);
      _filteredUsers.removeWhere((user) => user['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // Set the text direction to right-to-left (to suit Arabic language)
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xfff3f7f9), // Background color of the page

        appBar: AppBar(
          backgroundColor: Colors.white,
          // AppBar background color
          elevation: 0,
          // Remove shadow from the AppBar
          title: Image.asset(
            'assets/jisserLogo.jpeg', // Logo in the center
            width: 40,
            height: 40,
          ),
          centerTitle: true,
          // Center the title in the AppBar
          actions: [
            // Email icon in the top-right corner
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.email,
                color: Colors.blue,
              ),
            ),
          ],
          leading: const Padding(
            // Logout icon in the top-left corner
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.logout_sharp,
              color: Colors.red,
            ),
          ),
        ),

        body: _getSelectedPage(), // Show the selected page dynamically
        // Bottom navigation bar for page navigation
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          // Handle tap to switch pages
          items: const [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.groups), // Icon for users
                  Text('المستخدمين'), // Users label
                ],
              ),
              label: '', // No label here
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.medical_services), // Icon for specialists
                  Text('الأخصائيين'), // Specialists label
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.group), // Icon for sessions
                  Text('الجلسات'), // Sessions label
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.menu_book), // Icon for blog
                  Text('المدونة'), // Blog label
                ],
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  // User management page content (example)
  Widget _userManagementPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'إدارة المستخدمين', // Title in Arabic for managing users
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Space between title and search box

          // Search input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300, // Set the width of the search field
              child: TextField(
                controller: _searchController,
                // Controller to manage the text
                onChanged: (value) {
                  _filterUsers(value); // Filter users based on input
                },
                decoration: InputDecoration(
                  hintText: 'بحث', // Arabic placeholder text for search
                  prefixIcon: const Icon(Icons.search), // Search icon
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded borders
                  ),
                ),
              ),
            ),
          ),

          // Table to display user data
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Allow horizontal scrolling
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffeae9e9)),
                borderRadius:
                    BorderRadius.circular(8), // Rounded corners for table
              ),
              child: DataTable(
                columnSpacing: 18.0,
                // Space between columns
                dataRowHeight: 35,
                // Row height
                headingRowHeight: 35,
                // Heading row height
                headingTextStyle: const TextStyle(
                  color: Color(0xff2b2c2c),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                dataTextStyle: const TextStyle(fontSize: 11),
                columns: const [
                  DataColumn(label: Text('اسم المستخدم')),
                  // User name column
                  DataColumn(label: Text('المعُرف')),
                  // ID column
                  DataColumn(label: Text('البريد الإلكتروني')),
                  // Email column
                  DataColumn(label: Text('حذف')),
                  // Delete column
                ],
                rows: _buildUserRows(_filteredUsers.isEmpty
                    ? users
                    : _filteredUsers), // Display filtered or all users
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to generate the rows for the DataTable
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredUsers = []; // List for filtered users
  List<Map<String, String>> users = [
    // Example user data
    {'name': 'سارة', 'id': 'A1b2C3d4', 'email': 'jd@gmail.com'},
    {'name': 'ريم', 'id': 'XyZ9kLmN', 'email': 'sc@email.com'},
    {'name': 'محمد', 'id': 'qR5sTuV8', 'email': 'ms@outlook.com'},
    {'name': 'مها', 'id': 'mNpQrSt1', 'email': 'ew@gmail.com'},
    {'name': 'عبدالله', 'id': 'wX3Yz24', 'email': 'lj@gmail.com'},
    {'name': 'عبدالعزيز', 'id': 'B2C3D4E5', 'email': 'lb@yahoo.com'},
    {'name': 'عبير', 'id': 'F6G7H8J9', 'email': 'ce@outlook.com'},
    {'name': 'يوسف', 'id': 'JkLmNoP2', 'email': 'er@yahoo.com'},
    {'name': 'جنى', 'id': 'T5UuWx4Y', 'email': 'pr@gmail.com'},
    {'name': 'احمد', 'id': 'Z2A1B0C9', 'email': 'kc@email.com'},
  ];

  // Builds rows for the DataTable
  List<DataRow> _buildUserRows(List<Map<String, String>> userList) {
    return userList
        .map(
          (user) => DataRow(
            cells: [
              DataCell(Text(user['name']!)), // User's name
              DataCell(Text(user['id']!)), // User's ID
              DataCell(Text(user['email']!)), // User's email
              DataCell(
                // Delete button for each user
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                  onPressed: () =>
                      _deleteUser(user['id']!), // Deletes user on press
                ),
              ),
            ],
          ),
        )
        .toList(); // Convert each user data to DataRow
  }
}
