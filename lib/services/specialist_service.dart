import 'package:jisser_app/model/specialist_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SpecialistService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<Specialist>> getSpecialistsStream() {
    return _supabase
        .from('specialists')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((specialist) => Specialist.fromMap(specialist)).toList());
  }
}