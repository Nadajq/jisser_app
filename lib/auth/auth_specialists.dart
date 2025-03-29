import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSpecialists{
  Future<void> signUpSpecialist({
    required String email,
    required String password,
    required String name,
    required String specialty,
    required String qualification,
    required String yearsOfExperience,
    required String pdfUrl,
    required String imageUrl,
    required List<String> sessionTimes,
    required List<String> sessionDurations,
    required bool active,
    required String date,
  }) async {
    try {
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final user = authResponse.user;
      if (user == null) {
        throw Exception('User is not authenticated');
      }

      await Supabase.instance.client
          .from('specialists')
          .insert({
        'id': user.id,
        'name': name,
        'email': email,
        'specialty': specialty,
        'qualification': qualification,
        'years_of_experience': yearsOfExperience,
        'pdf_url': pdfUrl,
        'image_url': imageUrl,
        'session_times': sessionTimes,
        'session_duration': sessionDurations,
        'active': active,
        'date': date,
      });


      print('Specialist signed up and data inserted successfully!');
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> loginSpecialist({
    required String email,
    required String password,
  }) async {
    try {
      final specialistResponse = await Supabase.instance.client
          .from('specialists')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (specialistResponse == null) {
        throw Exception('هذا البريد الإلكتروني غير مسجل كأخصائي');
      }

      final authResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = authResponse.user;
      if (user == null) {
        throw Exception('فشل تسجيل الدخول');
      }

    } catch (e) {
      throw Exception(e);
    }
  }
}