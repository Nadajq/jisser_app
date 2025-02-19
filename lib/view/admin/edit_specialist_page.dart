import 'package:flutter/material.dart';
import 'package:jisser_app/model/specialist_model.dart';

class EditSpecialistPage extends StatefulWidget {
  final Specialist specialist;

  const EditSpecialistPage({required this.specialist});

  @override
  _EditSpecialistPageState createState() => _EditSpecialistPageState();
}

class _EditSpecialistPageState extends State<EditSpecialistPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? specialization;
  String? qualification;
  String accountStatus = 'قيد المراجعة';

  final List<String> specializations = Specialist.specialties;
  final List<String> qualifications = Specialist.qualifications;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      //const Color(0xFFEAF7FA), // لون الخلفية
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
              SizedBox(height: 30),
              Text(
                'تعديل حساب الأخصائي',
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
              buildLabeledDropdown(' : التخصص', specializations, specialization,
                  (value) {
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
                  buildStatusButton('نشط'),
                  const SizedBox(width: 8),
                  buildStatusButton('غير نشط'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                  //ScaffoldMessenger.of(context).showSnackBar(
                  //SnackBar(content: Text('تم تعديل البيانات بنجاح')),
                  //);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff105793),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                child:
                    const Text('تعديل', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      active: accountStatus == 'نشط',
    );
    // Update the list with the new specialist data
    int index = specialistsInfo.indexWhere((specialist) => specialist.id == updatedSpecialist.id);
    if (index != -1) {
      specialistsInfo[index] = updatedSpecialist; // Replace the old specialist with the updated one
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تعديل البيانات بنجاح')),
    );
    // Navigate back after submitting the form
    Navigator.pop(context);
  }
//update the specialistsInfo list with the updated data when the form is submitted
  void updateSpecialistData(Specialist updatedSpecialist) {
    // Find the index of the specialist in the list
    int index = specialistsInfo.indexWhere((specialist) => specialist.id == updatedSpecialist.id);

    if (index != -1) {
      // Update the specialist at the found index
      specialistsInfo[index] = updatedSpecialist;
      print("Specialist data updated locally");
    } else {
      print("Specialist not found");
    }
  }

  Widget buildLabeledField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              filled: true, // Enables background color
              fillColor: Colors.grey[100],
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
            decoration: InputDecoration(
              filled: true, // Enables background color
              fillColor: Colors.grey[100],
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
