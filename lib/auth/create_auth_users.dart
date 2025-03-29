import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAuthUsers {
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
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
      await Supabase.instance.client.from('userrs').insert({
        'id': user.id,
        'name': name,
        'email': email,
        'created_at':"${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-"
      });

    }
    catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
