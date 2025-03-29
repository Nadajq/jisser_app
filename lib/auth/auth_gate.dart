import 'package:flutter/material.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';
import 'package:jisser_app/view/user_login_page.dart';
import 'package:jisser_app/view/user_home_page.dart';
import 'package:jisser_app/view/specialist/booking_list_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _checkUserType(String email, BuildContext context) async {
    try {
      final specialistResponse = await Supabase.instance.client
          .from('specialists')
          .select()
          .eq('email', email)
          .maybeSingle();
      // Check userrs table
      final userResponse = await Supabase.instance.client
          .from('userrs')
          .select()
          .eq('email', email)
          .maybeSingle();
      if (userResponse != null) {
        // User found in userrs table
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
                )));
      } else if (specialistResponse != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BookingListPage(
                  specialist: Specialist(
                    id: specialistResponse['id'],
                    date: specialistResponse['date'],
                    name: specialistResponse['name'],
                    email: specialistResponse['email'],
                    imageUrl: specialistResponse['image_url'],
                    pdfUrl: specialistResponse['pdf_url'],
                    specialty: specialistResponse['specialty'],
                    qualification: specialistResponse['qualification'],
                    yearsOfExperience:
                    specialistResponse['years_of_experience'],
                    rating: specialistResponse['rating'],
                    sessionTimes: specialistResponse['session_times'],
                    sessionDurations:
                    specialistResponse['session_durations'],
                  ),
                )));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserLoginPage()));
      }

      // Check specialists table

      // if (specialistResponse != null) {
      //   // User found in specialists table

      // }

      // // User not found in either table
      // return const UserLoginPage();
    } catch (e) {
      print('Error checking user type: $e');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserLoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Show loading indicator while checking connection
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        // If user is authenticated
        if (session != null) {
          // Return FutureBuilder to handle async user type check
          return FutureBuilder<void>(
            future: _checkUserType(session.user.email!, context),
            builder: (context, snapshot) {
              // Show loading indicator while checking user type
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          );
        } else {
          // If not authenticated, return to login page
          return const UserLoginPage();
        }
      },
    );
  }
}
