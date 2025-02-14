import 'package:flutter/material.dart';

class editSpecialistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditSpecialistAccountScreen(),
    );
  }
}

class EditSpecialistAccountScreen extends StatefulWidget {
  @override
  _EditSpecialistAccountScreenState createState() =>
      _EditSpecialistAccountScreenState();
}

class _EditSpecialistAccountScreenState
    extends State<EditSpecialistAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? specialization;
  String? qualification;
  String accountStatus = 'قيد المراجعة';

  final List<String> specializations = [
    "أخصائي تخاطب",
    "أخصائي علاج وظيفي",
    "أخصائي تحليل سلوك تطبيقي",
    "أخصائي نفسي"
  ];
  final List<String> qualifications = ['بكالوريوس', 'ماجستير', 'دكتوراه'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe3e1e1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
            onPressed: () {
              Navigator.pop(context); //الرجوع إلى الصفحة السابقة
            },
          ),
          title: Center(
            child: Image.asset(
              'assets/jisserLogo.jpeg', // شعار التطبيق
              width: 40,
              height: 40,
            ),
          ),
          actions: [SizedBox(width: 48)], // لتوازن العناصر في الشريط العلوي
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تعديل حساب الأخصائي',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50),
                buildLabeledField(': اسم الأخصائي', nameController),
                const SizedBox(height: 16),
                buildLabeledField(': البريد الإلكتروني', emailController),
                const SizedBox(height: 16),
                buildLabeledDropdown(
                    ' : التخصص', specializations, specialization, (value) {
                  setState(() {
                    specialization = value;
                  });
                }),
                const SizedBox(height: 16),
                buildLabeledDropdown(
                    ': المؤهل العلمي', qualifications, qualification, (value) {
                  setState(() {
                    qualification = value;
                  });
                }),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    ': حالة الحساب  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildStatusButton('قيد المراجعة'),
                    const SizedBox(width: 8),
                    buildStatusButton('نشط'),
                    const SizedBox(width: 8),
                    buildStatusButton('مرفوض'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم تعديل البيانات بنجاح')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff105793),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  ),
                  child: const Text('تعديل',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildLabeledField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.left,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget buildLabeledDropdown(String label, List<String> items,
      String? selectedValue, Function(String?) onChanged) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xff105793)),
            iconEnabledColor: Color(0xff105793),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Align(
                  alignment: Alignment.centerRight, // هذا يغير اتجاه النص
                  child: Text(value),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget buildStatusButton(String status) {
    final isSelected = status == accountStatus;
    return GestureDetector(
      onTap: () {
        setState(() {
          accountStatus = status;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff105793) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xff9e9e9e)),
        ),
        child: Text(
          status,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
