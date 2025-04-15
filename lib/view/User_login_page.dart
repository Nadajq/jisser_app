import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/auth/auth_service.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/users_model.dart';
import 'package:jisser_app/view/specialist/specialist_login_page.dart';
import 'package:jisser_app/view/user_home_page.dart';
import 'package:jisser_app/view/user_sign_up_page.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin/admin_login_page.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validate inputs
    if (_emailController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_email,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_password,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Step 1: Check if user exists in userrs table
      final userResponse = await Supabase.instance.client
          .from('userrs')
          .select()
          .eq('email', _emailController.text)
          .maybeSingle();

      if (userResponse == null) {
        throw Exception('هذا البريد الإلكتروني غير مسجل');
      }

      // Step 2: Attempt authentication
      await AuthService().signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        CustomSnackBar.snackBarwidget(
          context: context,
          color: Colors.green,
          text: S.of(context).login_successfully,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserHomePage(
              user: Users(
                id: userResponse['id'],
                name: userResponse['name'],
                email: userResponse['email'],
                password: '',
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        if (e.toString().contains('هذا البريد الإلكتروني غير مسجل')) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).thsi_email_is_not_registered,
          );
        } else if (e.toString().contains("Invalid login credentials")) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).your_email_or_password_is_incorrect,
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
        log("Login error: $e");
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
    return BlocBuilder<ChangeLangaugeCubit, ChangeLangaugeState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(actions: [
              IconButton(
                icon: const Icon(Icons.language, color: Colors.indigo),
                onPressed: () {
                  BlocProvider.of<ChangeLangaugeCubit>(context)
                      .changeLangauge();
                  print("Change language");
                },
              ),
            ]),
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
                        S.of(context).login_in,
                        style: TextStyle(
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
                      onTap: _isLoading ? null : _handleLogin,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _isLoading ? Colors.grey : Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  S.of(context).login_in,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).you_dont_have_an_account),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: _isLoading
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserSignUpPage(),
                                    ),
                                  );
                                },
                          child: Text(
                            S.of(context).create_account,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _isLoading
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SpecialistLoginPage(),
                                ),
                              );
                            },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).login_as_specialist,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _isLoading
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminLoginPage(),
                                ),
                              );
                            },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).login_as_admin,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
