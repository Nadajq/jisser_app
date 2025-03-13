import 'package:flutter/material.dart';
import 'package:jisser_app/auth/auth_service.dart';
import 'package:jisser_app/view/specialist/specialist_login_page.dart';
import 'package:jisser_app/view/user_home_page.dart';
import 'package:jisser_app/view/user_sign_up_page.dart';

import 'admin/admin_login_page.dart';


class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  //get auth service
  final authService = AuthService();
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login button pressed
  void login() async{
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    //attempt login
    try{
      await authService.signInWithEmailPassword(email, password);
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
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
                    "تسجيل الدخول",
                    style: TextStyle(
                      color: Color(0xFF071164),
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Full width & height 50
                    backgroundColor: Colors.indigo, // Button color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Optional rounded corners
                    ),
                  ),
                  onPressed: login,
                  child: const Text("تسجيل الدخول"),
                ),
                const SizedBox(height: 20),


                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("ليس لديك حساب؟"),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserSignUpPage(),
                            ),
                                (route) => false);
                      },
                      child: const Text("إنشاء حساب",style: TextStyle(color: Colors.blue ),
                    ),

                ),




              ],
            ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SpecialistLoginPage())); //button to go to Specialist LoginPage
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color:  Colors.indigo.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(child: Text("تسجيل الدخول كمختص",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const AdminLoginPage(),)); //button to go to Specialist LoginPage
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color:  Colors.indigo.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(child: Text("تسجيل الدخول كمسؤل",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ),
            ],
          ),
        ],
              ),
        ),
    );

  }
}
