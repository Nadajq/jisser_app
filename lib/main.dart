import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jisser_app/view/User_login_page.dart';
import 'package:jisser_app/view/logo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDPeDkgIL52Fzvio3V4D8OY0ao-QTmMHRw',
              appId: '1:359974279916:android:4d355af1a8ee03f544a3c9',
              messagingSenderId: '359974279916',
              projectId: 'jisser-b9307'),
  )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      home: const logoPage(
        child: UserLoginPage(),
      ),
      //nasim
    );
  }
}
