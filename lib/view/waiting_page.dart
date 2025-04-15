import 'package:flutter/material.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/sessions_model.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';
import 'dart:async';

import 'package:jisser_app/view/chat_page/chat_page.dart'; // Import Timer

class WaitingPage extends StatefulWidget {
  final Users user;
  final Specialist specialist;
  final String date;
  final Sessions? session;
  const WaitingPage({super.key, required this.user, required this.specialist, required this.date, this.session});

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  double _opacity = 0.0; // Initial opacity for the fade animation
  double _scale = 1.0; // Initial scale for the image
  late Timer _timer; // Timer to control the repeating animation

  @override
  void initState() {
    super.initState();
    // Start the repeating animation
    _startAnimation();
    Future.delayed(const Duration(seconds: 5), () {
  if (mounted && widget.session != null) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          user: widget.user,
          specialist: widget.specialist,
          session: widget.session!,
        ),
      ),
    );
  }
});
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      setState(() {
        // Toggle opacity between 0.0 and 1.0
        _opacity = _opacity == 0.0 ? 1.0 : 0.0;
        // Toggle scale between 1.0 and 1.2
        _scale = _scale == 1.0 ? 1.2 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7EDEF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Animated image with fade and scale
            AnimatedOpacity(
              opacity: _opacity, // Animate the opacity
              duration: const Duration(milliseconds: 800), // Animation duration
              child: Transform.scale(
                scale: _scale, // Animate the scale
                child: Image.asset('assets/waiting_logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(0.9),
                ),
                S.of(context).please_wait_until_session_starts,
              ),
            ),
          ],
        ),
      ),
    );
  }
}