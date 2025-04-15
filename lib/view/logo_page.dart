import 'package:flutter/material.dart';


class logoPage extends StatefulWidget {
  final Widget? child;

  const logoPage({super.key, this.child});

  @override
  State<logoPage> createState() => _logoPageState();
}

class _logoPageState extends State<logoPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //backgroundColor: Color(0xFFE7F0F4), //0xFFC4DDE7
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center, // Moves content towards the top
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
             Hero(
               tag: 'logo',
               child: Image.asset(
                 'assets/waiting_logo.png',
                  width: 150,
                 height: 150,
               
                ),
             ),
              const Text(
                "جسر",
                style: TextStyle(
                    color: Color(0xFF546E78),
                    fontWeight: FontWeight.bold,
                    fontSize: 47),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
