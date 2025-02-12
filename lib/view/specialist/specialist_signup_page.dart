import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/view/specialist/specialist_home_page.dart';
import 'package:jisser_app/view/specialist/specialist_login_page.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';

class SpecialistSignupPage extends StatefulWidget {

  const SpecialistSignupPage({super.key});

  @override
  State<SpecialistSignupPage> createState() => _SpecialistSignupPageState();
}

class _SpecialistSignupPageState extends State<SpecialistSignupPage> {
  String? selectedSpecialty;
  String? selectedQualification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.language,color: Colors.indigo,),// Language change icon
          onPressed: () {
            // Add your language-switching logic here
            print("Change language");
          },
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:  Column(
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

            const FormContainerWidget(
              hintText: "اسم المستخدم",
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            const FormContainerWidget(
              hintText: "البريد الالكتروني",
              isPasswordField: false,
            ),
            const SizedBox(height: 20),

            const FormContainerWidget(
              hintText: "كلمة المرور",
              isPasswordField: true,
            ),
            const SizedBox(height: 20),
            // Specialty dropdown
        Align(
          alignment: Alignment.centerRight,
          child:
            DropdownButtonFormField<String>( //dropdown field selected value type is String
              value: selectedSpecialty ,// holds the selected option
              hint: const Text("اختر تخصصك",textAlign: TextAlign.right) ,
              decoration: InputDecoration(//Styles the dropdown field by adding a border with rounded corners.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              ),

              isExpanded: true,//makes sure dropdown aligns properly
              items: Specialist.specialties.map((String specialty){//creates the dropdown options using the specialties list from the Specialist model.
                return DropdownMenuItem<String>(//Converts each specialty into a DropdownMenuItem
                  value: specialty,// value stored when selected
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(specialty, textAlign: TextAlign.right),//text displayed to the right
                  ),
                );
              }).toList(),//converts the mapped items into a list
              onChanged: (String? newValue){
                setState(() {//Updates selectedSpecialty and refreshes the UI.
                  selectedSpecialty = newValue;//holds the chosen specialty.
                });
              },
            ),
        ),
            const SizedBox(height: 20),
            // Qualification dropdown
        Align(
          alignment: Alignment.centerRight,
          child:
            DropdownButtonFormField<String>(
              value: selectedQualification,
              hint:  Text("اختر مؤهلك العلمي",textAlign: TextAlign.right),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              isExpanded: true,//makes sure dropdown aligns properly
              items: Specialist.qualifications.map((String qualification) {////Maps through the list of qualifications
                return DropdownMenuItem<String>(
                  value: qualification,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child:  Text(qualification, textAlign: TextAlign.right),//text displayed to the right),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedQualification = newValue;
                });
              },
            ),
        ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Text(
                    "إنشاء حساب",
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 20,
            ),


            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SpecialistLoginPage(),
                        ),
                            (route) => false);
                  },
                  child: const Text("تسجيل دخول كأخصائي",style: TextStyle(color: Colors.blue ),
                  ),

                ),
                const SizedBox(width: 5,),

                const Text(" لديك حساب في جسر ؟"),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
