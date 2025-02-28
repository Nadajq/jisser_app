import 'package:flutter/material.dart';
import 'package:jisser_app/model/specialist_model.dart';

// Edit Specialist Page - Allows editing specialist details
class EditSpecialistPage extends StatefulWidget {
  final Specialist specialist;

  const EditSpecialistPage({required this.specialist});

  @override
  _EditSpecialistPageState createState() => _EditSpecialistPageState();
}

class _EditSpecialistPageState extends State<EditSpecialistPage> {
  // Controllers for text input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? specialization;
  String? qualification;
  String accountStatus = 'قيد المراجعة'; // Default status: "Under Review"

  // Lists of available specializations and qualifications
  final List<String> specializations = Specialist.specialties;
  final List<String> qualifications = Specialist.qualifications;

  @override
  void initState() {
    super.initState();
    // Pre-fill fields with existing specialist data
    nameController.text = widget.specialist.name;
    emailController.text = widget.specialist.email;
    specialization = widget.specialist.specialty;
    qualification = widget.specialist.qualification;
    accountStatus = widget.specialist.active ? 'نشط' : 'غير نشط';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.asset(
            'assets/jisserLogo.jpeg',
            width: 40,
            height: 40,
          ),
        ),
        actions: [SizedBox(width: 48)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                'تعديل حساب الأخصائي', // Edit Specialist Account
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF08174A),
                ),
              ),
              const SizedBox(height: 50),
              buildLabeledField(': اسم الأخصائي', nameController),
              const SizedBox(height: 16),
              buildLabeledField(': البريد الإلكتروني', emailController),
              const SizedBox(height: 16),
              buildLabeledDropdown(' : التخصص', specializations, specialization, (value) {
                setState(() {
                  specialization = value;
                });
              }),
              const SizedBox(height: 16),
              buildLabeledDropdown(': المؤهل العلمي', qualifications, qualification, (value) {
                setState(() {
                  qualification = value;
                });
              }),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  ': حالة الحساب  ', // Account Status
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildStatusButton('نشط'), // Active
                  const SizedBox(width: 8),
                  buildStatusButton('غير نشط'), // Inactive
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff105793),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                child: const Text('تعديل', style: TextStyle(color: Colors.white)), // Edit Button
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to submit the updated specialist data
  void _submitForm() {
    final updatedSpecialist = Specialist(
      id: widget.specialist.id,
      name: nameController.text,
      imageUrl: widget.specialist.imageUrl,
      email: emailController.text,
      password: widget.specialist.password,
      specialty: specialization!,
      qualification: qualification!,
      yearsOfExperience: widget.specialist.yearsOfExperience,
      rating: widget.specialist.rating,
      sessionTimes: widget.specialist.sessionTimes,
      sessionDurations: widget.specialist.sessionDurations,
      active: accountStatus == 'نشط',
    );

    setState(() { // Update specialist information in the list
      int index = specialistsInfo.indexWhere((specialist) =>
      specialist.id == updatedSpecialist.id);
      if (index != -1) {
        specialistsInfo[index] = updatedSpecialist;
      }
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تعديل البيانات بنجاح')), // Successfully updated
    );
    Navigator.pop(context);
  }

  // Function to build labeled text fields
  Widget buildLabeledField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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

  // Function to build labeled dropdowns
  Widget buildLabeledDropdown(String label, List<String> items, String? selectedValue, Function(String?) onChanged) {
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
                  alignment: Alignment.centerRight,
                  child: Text(value),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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

  // Function to build status selection buttons
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
