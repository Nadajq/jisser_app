import 'package:flutter/material.dart';

class ManageSpecialistPage extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Directionality(
      // Set the text direction to right-to-left (to suit Arabic language)
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // Set the background color of the page
        backgroundColor: Color(0xfff3f7f9),

        // Define the AppBar (top bar of the application)
        appBar: AppBar(
          backgroundColor: Colors.white, // Set the AppBar background color
          elevation: 0, // Remove shadow from AppBar

          // Add a logo in the center of the AppBar
          title: Image.asset(
            'assets/jisserLogo.jpeg',
            width: 40,
            height: 40,
          ),

          // Center the title
          centerTitle: true,

          // Add an email icon on the right
          actions: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.email,
                color: Colors.blue,
              ),
            ),
          ],

          // Add a logout icon on the left
          leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.logout_sharp,
              color: Colors.red,
            ),
          ),
        ),
  // Define the body (main part) of the page
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the elements on the page
            children: [
              // Add a heading with text style formatting
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'إدارة الأخصائيين', // Text shown to the user
                  style: TextStyle(
                    fontSize: 18, // Font size
                    fontWeight: FontWeight.bold, // Make the text bold
                    color: Colors.black, // Text color
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add some space between the title and the next elements

              // Add a search field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300, // Set the width of the search field
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'بحث', // Placeholder text for the search field
                      prefixIcon: const Icon(Icons.search), // Add a search icon inside the field
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Round the corners of the field
                      ),
                    ),
                  ),
                ),
              ),
 // Add a table to display user data
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allow horizontal scrolling if there is a lot of data
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the table
                    border: Border.all(color: const Color(0xffeae9e9)), // Border color of the table
                    borderRadius: BorderRadius.circular(8), // Rounded corners for the table
                  ),
                  child: DataTable(
                    columnSpacing: 18.0, // Space between columns
                    dataRowHeight: 35, // Height of data rows
                    headingRowHeight: 35, // Height of the heading row
                    headingTextStyle: const TextStyle(
                      color: Color(0xff2b2c2c), // Color of the heading text
                      fontWeight: FontWeight.bold, // Bold heading text
                      fontSize: 12, // Font size for the heading
                    ),
                    dataTextStyle: const TextStyle(
                      fontSize: 11, // Font size for data rows
                    ),
                    columns: const [
                      DataColumn(label: Text('اسم الأخصائي')), // Column for user name
                      DataColumn(label: Text('ID')), // Column for ID
                      DataColumn(label: Text('المؤهل العلمي')),
                      DataColumn(label: Text('الحالة')),
                      DataColumn(label: Text('تعديل')), // Column for email
                      DataColumn(label: Text('حذف')), // Column for delete button
                    ],
                    rows: _buildUserRows(), // Function to build the user rows
                  ),
                ),
              ),
            ],
          ),
        ),

   // Add a Bottom Navigation Bar for page navigation
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white, // Background color of the bar
          selectedItemColor: Colors.blue, // Color of the selected item
          unselectedItemColor: Colors.blue, // Color of unselected items
          type: BottomNavigationBarType.fixed, // Fixed type for the bar
          items: const [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.groups), // Icon for users
                  Text('المستخدمين'), // Label for users
                ],
              ),
              label: '', // No label here
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.medical_services), // Icon for specialists
                  Text('الأخصائيين'), // Label for specialists
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.group), // Icon for sessions
                  Text('الجلسات'),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.menu_book), // Icon for blog
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
}
 List<DataRow> _buildUserRows() {
    final users = [
      {'name': 'د.أحمد', 'id': 'A1b2C34d', 'المؤهل': 'بكالوريس', 'الحالة': 'نشط'},
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
     return users
        .map(
          (user) => DataRow(cells: [
            DataCell(Text(user['name']!)), // Display user name
            DataCell(Text(user['id']!)), // Display user ID
            DataCell(Text(user['email']!)), // Display user email
            const DataCell(Icon(Icons.delete, color: Colors.red, size: 18)), // Add a delete icon
          ]),
        )
        .toList();
  }

