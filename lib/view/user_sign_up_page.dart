import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/auth/create_auth_users.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/view/user_login_page.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (_nameController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_username,
      );
      return false;
    }

    if (_emailController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_email,
      );
      return false;
    }

    if (_passwordController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_password,
      );
      return false;
    }

    if (_confirmPasswordController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
          context: context,
          color: Colors.red,
          text: S.of(context).please_enter_confirm_password);
      return false;
    }

    // Password length check
    if (_passwordController.text.length < 8) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).password_must_be_at_least_8_characters_long,
      );
      return false;
    }

    // Password complexity checks
    if (!_passwordController.text.contains(RegExp(r'[A-Z]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).passwrod_must_contain_at_least_one_uppercase_letter,
      );
      return false;
    }

    if (!_passwordController.text.contains(RegExp(r'[a-z]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).passwrod_must_contain_at_least_one_lowercase_letter,
      );
      return false;
    }

    if (!_passwordController.text.contains(RegExp(r'[0-9]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).passwrod_must_contain_at_least_one_number,
      );
      return false;
    }

    if (!_passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text:
            S.of(context).passwrod_must_contain_at_least_one_special_character,
      );
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).the_password_does_not_match,
      );
      return false;
    }

    return true;
  }

  Future<void> _handleSignUp() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Check if email already exists in userrs table
      final existingUser = await Supabase.instance.client
          .from('userrs')
          .select()
          .eq('email', _emailController.text)
          .maybeSingle();

      if (existingUser != null) {
        throw Exception('User already registered');
      }

      // Proceed with signup
      await CreateAuthUsers().signUpUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        CustomSnackBar.snackBarwidget(
          context: context,
          color: Colors.green,
          text: S.of(context).the_account_has_been_created_successfully,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const UserLoginPage()),
          (route) => false,
        );
      }
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
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/jisserLogo.jpeg',
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
                        S.of(context).create_new_account,
                        style: const TextStyle(
                          color: Color(0xFF071164),
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContainerWidget(
                      controller: _nameController,
                      hintText: S.of(context).user_name,
                      isPasswordField: false,
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
                    FormContainerWidget(
                      controller: _confirmPasswordController,
                      hintText: S.of(context).confirm_password,
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _isLoading ? null : _handleSignUp,
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
                                  S.of(context).create_new_account,
                                  style: const TextStyle(
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
                        Text(S.of(context).you_dont_have_an_account_in_jisser),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: _isLoading
                              ? null
                              : () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserLoginPage(),
                                    ),
                                    (route) => false,
                                  );
                                },
                          child: Text(
                            S.of(context).login_in,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
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
