import 'package:flutter/material.dart';

import 'User_login_page.dart';

class logoPage extends StatefulWidget {
   final Widget? child;
  const logoPage({super.key,this.child});

  @override
  State<logoPage> createState() => _logoPageState();
}

class _logoPageState extends State<logoPage> {



  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> widget.child! ), (route) => false);
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "جسر",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
