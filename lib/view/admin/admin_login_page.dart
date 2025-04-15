import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';

import 'package:jisser_app/view/widgets/form_container_widget.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'manage_users_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginAdmin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check hardcoded admin credentials (optional fallback)
    if (email == "admin" && password == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ManageUsersPage(),
        ),
      );
      CustomSnackBar.snackBarwidget(
        context: context,
        text: S.of(context).login_successfully,
        color: Colors.green,
      );
      return;
    }

    try {
      final supabase = Supabase.instance.client;

      // 1. First try to sign in
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // 2. Check if user exists in admin table
      final adminData = await supabase
          .from('admin') // or your admin table name
          .select()
          .eq('email', email)
          .eq('role', 'admin') // assuming you have a role column
          .single();

      // Success - navigate to admin page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ManageUsersPage(),
          ),
        );
        CustomSnackBar.snackBarwidget(
          context: context,
          text: S.of(context).login_successfully,
          color: Colors.green,
        );
      }
    } on AuthException catch (error) {
      CustomSnackBar.snackBarwidget(
        context: context,
        text: error.message,
        color: Colors.red,
      );
    } catch (error) {
      CustomSnackBar.snackBarwidget(
        context: context,
        text: S.of(context).your_email_or_password_is_incorrect,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLangaugeCubit, ChangeLangaugeState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
                          title: Row(
                            textDirection: TextDirection.rtl,
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
                        value: 1,
                        child: ListTile(
                          title: Row(
                            textDirection: TextDirection.rtl,
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
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/waiting_logo.png',
                      width: 150,
                      height: 150,
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
                        S.of(context).login_as_admin,
                        style: const TextStyle(
                          color: Color(0xFF071164),
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContainerWidget(
                      controller: _emailController,
                      hintText: S.of(context).email,
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 20),
                    FormContainerWidget(
                      controller: _passwordController,
                      hintText: S.of(context).password,
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _loginAdmin();
                        //button to go to user home page
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          S.of(context).login_in,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
