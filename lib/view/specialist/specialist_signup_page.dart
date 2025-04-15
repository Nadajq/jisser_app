import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jisser_app/auth/auth_specialists.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/view/widgets/form_container_widget.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jisser_app/view/specialist/specialist_login_page.dart';

class SpecialistSignupPage extends StatefulWidget {
  const SpecialistSignupPage({super.key});

  @override
  State<SpecialistSignupPage> createState() => _SpecialistSignupPageState();
}

class _SpecialistSignupPageState extends State<SpecialistSignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _yearsOfExperienceController.dispose();
    super.dispose();
  }

  static const List<String> specialties = [
    "أخصائي تخاطب",
    "أخصائي علاج وظيفي",
    "أخصائي تحليل سلوك تطبيقي",
    "أخصائي نفسي",
  ];

  static const List<String> qualifications = [
    "بكالوريوس",
    "ماجستير",
    "دكتوراه",
  ];

  String? selectedSpecialty;
  String? selectedQualification;
  PlatformFile? _pdfFile;
  XFile? _imageFile;

  Future<void> _pickPDF() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _pdfFile = result.files.first;
        });
      }
    } catch (e) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).there_was_an_error_selecting_file,
      );
      log("PDF picker error: $e");
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).there_was_an_error_selecting_image,
      );
      log("Image picker error: $e");
    }
  }

  Future<String?> _uploadFile(dynamic file, String bucketName) async {
    try {
      Uint8List fileBytes;
      String fileExtension;

      if (file is PlatformFile) {
        if (file.path == null) {
          throw Exception('PDF file is invalid or missing');
        }
        fileBytes = await File(file.path!).readAsBytes();
        fileExtension = file.extension ?? 'pdf';
      } else if (file is XFile) {
        fileBytes = await file.readAsBytes();
        fileExtension = file.path.split('.').last;
      } else {
        throw Exception('Unsupported file type');
      }

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
      await Supabase.instance.client.storage
          .from(bucketName)
          .uploadBinary(fileName, fileBytes);

      return Supabase.instance.client.storage
          .from(bucketName)
          .getPublicUrl(fileName);
    } catch (e) {
      log('Error uploading file: $e');
      rethrow;
    }
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

    if (selectedSpecialty == null) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_select_specialization,
      );
      return false;
    }

    if (selectedQualification == null) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_select_qualification,
      );
      return false;
    }

    if (_yearsOfExperienceController.text.isEmpty) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_enter_experience,
      );
      return false;
    }

    if (_pdfFile == null) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_upload_personal_file,
      );
      return false;
    }

    if (_imageFile == null) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_upload_personal_image,
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
      // Upload files
      final pdfUrl = await _uploadFile(_pdfFile!, 'pdfs');
      final imageUrl = await _uploadFile(_imageFile!, 'images');

      // Register specialist
      await AuthSpecialists().signUpSpecialist(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        specialty: selectedSpecialty!,
        qualification: selectedQualification!,
        yearsOfExperience: _yearsOfExperienceController.text,
        pdfUrl: pdfUrl!,
        imageUrl: imageUrl!,
        sessionTimes: [
          "8:00",
          "9:00",
          "3:00",
        ],
        sessionDurations: [
          "30 دقيقة / 150 ر.س",
          "1 ساعة / 250 ر.س",
        ],
        active: false,
        date:
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      );
      if (mounted) {
        CustomSnackBar.snackBarwidget(
          context: context,
          color: Colors.green,
          text: S.of(context).the_account_has_been_created_successfully,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SpecialistLoginPage()),
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
              elevation: 0,
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
                      'assets/waiting_logo.png',
                      width: 120,
                      height: 120,
                    ),
                    Text(
                      S.of(context).jisser,
                      style: const TextStyle(
                        color: Color(0xFF071164),
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        S.of(context).create_specialist_account,
                        style: const TextStyle(
                          color: Color(0xFF071164),
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Form Fields with updated style
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
                    // Updated Dropdown style to match FormContainerWidget
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: S.of(context).specialization,
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          items: specialties.map((specialty) {
                            return DropdownMenuItem<String>(
                              value: specialty,
                              child: Text(specialty),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => selectedSpecialty = value),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: S.of(context).qualification,
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          items: qualifications.map((qualification) {
                            return DropdownMenuItem<String>(
                              value: qualification,
                              child: Text(qualification),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => selectedQualification = value),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    FormContainerWidget(
                      controller: _yearsOfExperienceController,
                      hintText: S.of(context).years_of_experience,
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 20),

                    // File Upload Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: _isLoading ? null : _pickPDF,
                              child: Text(
                                _pdfFile == null
                                    ? S.of(context).upload_personal_file
                                    : _pdfFile!.name,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: _isLoading ? null : _pickImage,
                              child: Text(
                                _imageFile == null
                                    ? S.of(context).upload_personal_image
                                    : _imageFile!.name,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
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
                                  S.of(context).create_account,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _isLoading
                              ? null
                              : () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SpecialistLoginPage(),
                                    ),
                                    (route) => false,
                                  );
                                },
                          child: Text(
                            S.of(context).login_as_specialist,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(S.of(context).you_dont_have_an_account),
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
