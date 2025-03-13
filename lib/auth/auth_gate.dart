import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jisser_app/view/User_login_page.dart';
import 'package:jisser_app/view/user_home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/center_model.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //listen for auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      //build appropriate page based on auth state
      builder: (context, snapshot) {
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return UserHomePage();
        } else {
          return UserLoginPage();
        }
      },
    );
  }

}