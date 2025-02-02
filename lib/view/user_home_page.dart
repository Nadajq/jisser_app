import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("icon"),
      ),
      body: const Center(
        child: Text("jisser home page"),
      ),
    );
  }
}
