import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (emailController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_email,
      );
      return false;
    }

    if (passwordController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_password,
      );
      return false;
    }

    // Password length check
    if (passwordController.text.length < 8) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).password_must_be_at_least_8_characters_long,
      );
      return false;
    }

    // Password complexity checks
    if (!passwordController.text.contains(RegExp(r'[A-Z]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).passwrod_must_contain_at_least_one_uppercase_letter,
      );
      return false;
    }

    if (!passwordController.text.contains(RegExp(r'[a-z]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).passwrod_must_contain_at_least_one_lowercase_letter,
      );
      return false;
    }

    if (!passwordController.text.contains(RegExp(r'[0-9]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).passwrod_must_contain_at_least_one_number,
      );
      return false;
    }

    if (!passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text:
            S.of(context).passwrod_must_contain_at_least_one_special_character,
      );
      return false;
    }

    return true;
  }

  Future<void> _handlingAddAdmin() async {
    // Validate form
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // 1. Sign up the new user
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user == null) {
        throw Exception('User registration failed');
      }

      // 2. Add admin role to the user in your profiles table
      await supabase.from('admin').upsert({
        'admin_id': res.user!.id,
        'email': email,
        'role': 'admin', // Assuming you have a role column
        'created_at': DateTime.now().toIso8601String(),
      });

      // Show success message
      // if (mounted) {
      CustomSnackBar.snackBarwidget(
          context: context,
          color: Colors.green,
          text: S.of(context).admin_added_successfully);
      Navigator.pop(context); // Return to previous screen
      // }
    } catch (e) {
      if (mounted) {
        if (e.toString().contains("User already registered")) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).this_email_is_already_registered,
          );
        } else if (e.toString().contains("Connection timed out") ||
            e.toString().contains("ClientException with SocketException")) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).check_your_internet_connection,
          );
        } else {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).there_was_an_error_try_again_later,
          );
        }
        log("Signup error: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/jisserLogo.jpeg",
              height: 30,
            )
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(7),
            child: PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: Colors.blueAccent),
              offset: const Offset(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: const Icon(Icons.mail, color: Colors.blueAccent),
                    title: const Text("jisser@gmail.com",
                        style: TextStyle(fontSize: 13)),
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -2),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: ListTile(
                    title: Row(
                      children: [
                        const Icon(Icons.language,
                            color: Colors.blueAccent, size: 20),
                        const SizedBox(width: 5),
                        Text(S.of(context).change_language,
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                    onTap: () {
                      BlocProvider.of<ChangeLangaugeCubit>(context)
                          .changeLangauge();
                      Navigator.pop(context);
                    },
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: ListTile(
                    title: Row(
                      children: [
                        const Icon(Icons.exit_to_app,
                            color: Color(0xfff90606), size: 20),
                        const SizedBox(width: 5),
                        Text(S.of(context).back,
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                createRectTween: (begin, end) {
                  return RectTween(
                    begin: const Rect.fromLTRB(0, 0, 0, 60),
                    end: const Rect.fromLTRB(0, 0, 0, 0),
                  );
                },
                child: Image.asset(
                  'assets/waiting_logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Text(
                S.of(context).jisser,
                style: const TextStyle(
                  color: Color(0xFF071164),
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  S.of(context).add_admin,
                  style: const TextStyle(
                    color: Color(0xFF071164),
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FormContainerWidget(
                controller: emailController,
                hintText: S.of(context).email,
                isPasswordField: false,
              ),
              const SizedBox(height: 20),
              FormContainerWidget(
                controller: passwordController,
                hintText: S.of(context).password,
                isPasswordField: true,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _isLoading ? null : _handlingAddAdmin,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _isLoading ? Colors.grey : Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            S.of(context).add_admin,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
