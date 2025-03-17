import 'package:flutter/material.dart';
import 'package:jisser_app/view/user_chat_page.dart';


class WaitingPage  extends StatefulWidget {
  final Widget? child;

  const WaitingPage({super.key, this.child});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      // Check if the widget is still mounted before navigating
      if (mounted) {
        if (widget.child != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => widget.child!),
                (route) => false,
          );
        } else {
          // Handle the case where child is null
          // You might navigate to a default page or show an error
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UserChatPage()), // Replace with your default page
                (route) => false,
          );
        }
      }
    });
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
              Image.asset(
                'assets/jisserLogo.jpeg',
                width: 150,
                height: 150,

              ),
              Text(
                "الرجاء الانتظار حتى موعد بدء الجلسة",
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
