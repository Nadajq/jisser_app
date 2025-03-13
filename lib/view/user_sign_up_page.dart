import 'package:flutter/material.dart';
import 'package:jisser_app/auth/auth_service.dart';
import 'package:jisser_app/view/User_login_page.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {

  //get auth service
  final authService = AuthService();
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //sign up button pressed
  void signUp() async{
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    //check that password match
    if(password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("كلمة المرور غير صحيحة")));
      return;
    }
    //attempt sign up
    try{
      await authService.signUpWithEmailPassword(email, password);
      //pop this register page
      Navigator.pop(context);
    }
    catch(e){
      if(mounted){
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
            icon: Icon(Icons.language,color: Colors.indigo,),// Language change icon
              onPressed: () {
                // Add your language-switching logic here
                print("Change language");
              },
            ),

        ),
        body: ListView(

            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    "إنشاء حساب",
                    style: TextStyle(
                      color: Color(0xFF071164),
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

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
                //confirm password
                TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(labelText: "تأكيد كلمة المرور" ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
               //button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Full width & height 50
                    backgroundColor: Colors.indigo, // Button color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Optional rounded corners
                    ),
                  ),
                    onPressed: signUp,
                    child: const Text("إنشاء حساب"),
                ),
                const SizedBox(height: 20),
               /* Container(
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
                ),*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("لديك حساب في جسر ؟"),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserLoginPage(),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        "تسجيل دخول",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),


                  ],
                ),
              ],
            ),
        ],
          ),
        ),
      );
  }
}
