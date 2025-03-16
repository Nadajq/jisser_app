import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:jisser_app/view/specialist/schedule_page.dart';

class SpecialistHomePage extends StatefulWidget {
  const SpecialistHomePage({super.key});

  @override
  _SpecialistHomePageState createState() => _SpecialistHomePageState();
}

class _SpecialistHomePageState extends State<SpecialistHomePage> {
  int _selectedIndex = 0; // Track selected tab index
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Handle bottom navigation taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Different pages based on the selected index
  Widget _getSelectedPage() {
    if (_selectedIndex != 0) {
        return SchedulePage(); // Navigate to specialists page
    }
    else {
      return _specialistSessionsPage(); // Default to user management page
    }
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.logout,
                color: Colors.red, size: 20), // أيقونة الرجوع للخلف
            onPressed: () {
              // تنفيذ الرجوع للخلف
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Image.asset(
              'assets/jisserLogo.jpeg',
              // إدراج صورة الشعار في منتصف شريط التطبيق
              width: 40,
              height: 40,
            ),
          ),
          actions: [SizedBox(width: 48)], // توازن لموائمة الصورة في المنتصف
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
      icon: Icon(Icons.calendar_month),
        label: 'جدولة المواعيد',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'قائمة الحجوزات',
      ),
      ],
      ),
      ),
    );
  }
  // User management page content (example)
  Widget _specialistSessionsPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("specialist home page"),
          ),
        ],
      ),
    );
  }
  }
