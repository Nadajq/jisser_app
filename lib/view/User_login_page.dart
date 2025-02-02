import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("icon"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:  Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Moves content towards the top
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centers content horizontally
          children: [
            // Image.asset(
            //  'assets/logo.png', // Replace with your image path
            //   width: 150, // Adjust size as needed
            //   height: 150,
            //  ),
            Text(
              "جسر",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),

            FormContainerWidget(
              hintText: "اسم المستخدم",
              isPasswordField: false,
            ),
            SizedBox(height: 20),

            FormContainerWidget(
              hintText: "كلمة المرور",
              isPasswordField: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            )

          ],
        ),
      ),
    );
  }
}
