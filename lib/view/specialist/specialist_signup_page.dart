import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/view/specialist/specialist_home_page.dart';
import 'package:jisser_app/view/specialist/specialist_login_page.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';

import '../../auth/auth_service.dart';

class SpecialistSignupPage extends StatefulWidget {

  const SpecialistSignupPage({super.key});

  @override
  State<SpecialistSignupPage> createState() => _SpecialistSignupPageState();
}

class _SpecialistSignupPageState extends State<SpecialistSignupPage> {

  final authService = AuthService();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();
  static List<String> specialties = [
    "أخصائي تخاطب",
    "أخصائي علاج وظيفي",
    "أخصائي تحليل سلوك تطبيقي",
    "أخصائي نفسي",
  ];

  static List<String> qualifications = [
    "بكالوريوس",
    "ماجستير",
    "دكتوراه",
  ];
  String? selectedSpecialty;
  String? selectedQualification;

  void signUp() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final yearsOfExperience = _yearsOfExperienceController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || selectedSpecialty == null || selectedQualification == null|| yearsOfExperience == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("يرجى ملء جميع الحقول")));
      return;
    }
    try {
    /*  await authService.signUpSpecialist(
        email: email,
        password: password,
        name: name,
        specialty: selectedSpecialty!,
        qualification: selectedQualification!,
        yearsOfExperience: yearsOfExperience,
      );*/

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم إنشاء الحساب اخصائي بنجاح")));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SpecialistLoginPage()),
            (route) => false,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.language,color: Colors.indigo,),// Language change icon
            onPressed: () {
              // Add your language-switching logic here
              print("Change language");
            },
          ),

        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          children: [ Column(
            mainAxisAlignment: MainAxisAlignment.start, // Moves content towards the top
            crossAxisAlignment: CrossAxisAlignment.center, // Centers content horizontally
            children: [
              Image.asset(
                'assets/jisserLogo.jpeg',
                width: 120,
                height: 120,
              ),
              const Text(
                "جسر",
                style: TextStyle(
                  color: Color(0xFF071164),
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  " إنشاء حساب أخصائي",
                  style: TextStyle(
                    color: Color(0xFF071164),
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //user name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "اسم المستخدم" ),
              ),

              const SizedBox(height: 20),
              //email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "البريد الالكتروني" ),
              ),

              SizedBox(height: 20),
              //password
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "كلمة المرور" ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Specialty Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "التخصص"),
                items: specialties.map((specialty) {
                  return DropdownMenuItem<String>(
                    value: specialty,
                    child: Text(specialty),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSpecialty = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Qualification dropdown
              // Specialty Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "المؤهل العلمي"),
                items: qualifications.map((qualifications) {
                  return DropdownMenuItem<String>(
                    value: qualifications,
                    child: Text(qualifications),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedQualification = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              //yearsOfExperience
              TextField(
                controller: _yearsOfExperienceController,
                decoration: const InputDecoration(labelText: "سنوات الخبرة" ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                onPressed: signUp,
                child: const Text("إنشاء حساب"),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SpecialistLoginPage()),
                          (route) => false,
                    );
                  },
                  child: const Text("تسجيل دخول كأخصائي", style: TextStyle(color: Colors.blue)),
                ),
                const SizedBox(width: 5),
                const Text("لديك حساب في جسر؟"),
              ]),
            ],
        ),
        ]
      ),
      ),
    );
  }
}