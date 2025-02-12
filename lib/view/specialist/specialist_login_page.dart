import 'package:flutter/material.dart';
import 'package:jisser_app/view/specialist/specialist_home_page.dart';
import 'package:jisser_app/view/specialist/specialist_signup_page.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';


class SpecialistLoginPage extends StatelessWidget {
  const SpecialistLoginPage({super.key});

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
          mainAxisAlignment:
          MainAxisAlignment.start, // Moves content towards the top
          crossAxisAlignment:
          CrossAxisAlignment.center, // Centers content horizontally
          children: [
            Image.asset(
              'assets/jisserLogo.jpeg',
              width: 150,
              height: 150,

            ),
            const Text(
              "جسر",
              style: TextStyle(
                color: Color(0xFF071164),
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                " تسجيل الدخول كأخصائي",
                style: TextStyle(
                  color: Color(0xFF071164),
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SpecialistHomePage())); //button to go to user home page
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color:  Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child: Text("تسجيل الدخول",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            ),
            const SizedBox(height: 20,),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SpecialistSignupPage(),
                        ),
                            (route) => false);
                  },
                  child: const Text("إنشاء حساب أخصائي",style: TextStyle(color: Colors.blue ),
                  ),

                ),
                const SizedBox(width: 5,),

                const Text("ليس لديك حساب؟"),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
