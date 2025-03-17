import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  static List<List<String>> sessionTimes = [
    ["10:00 ص", "2:00 م", "5:00 م"],
    ["9:00 م", "8:00 م", "4:30 م"],
    ["8:30 م", "11:00 ص", "3:00 م"],
  ];
  List<String>? selectedTimes;
  DateTime? selectedDate;

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

  /*Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: Colors.blueAccent,
              ),
              title: Text(selectedDate == null
                  ? 'اختر اليوم والتاريخ'
                  : '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              leading: Icon(
                Icons.access_time,
                color: Colors.blueAccent,
              ),
              title: DropdownButtonFormField<List<String>>(
                decoration: const InputDecoration(labelText: "اختر الوقت"),
                items: sessionTimes.map((timeGroup) {
                  return DropdownMenuItem<List<String>>(
                    value: timeGroup,
                    child: Directionality( // Ensures text in dropdown is RTL
                      textDirection: TextDirection.rtl,
                      child: Text(timeGroup.join(" - ")), // Show all 3 times as one item
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTimes = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // منطق الحفظ هنا
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم حفظ الموعد')),
                );
              },
              child: Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
