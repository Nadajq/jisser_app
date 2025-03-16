import 'package:jisser_app/model/center_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CenterService {
  final SupabaseClient _supabaseClient;

  CenterService() : _supabaseClient = Supabase.instance.client;

  // Stream to get all centers
  Stream<List<Centers>> getCentersStream() {
    return _supabaseClient
        .from('centers')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((centersMap) => Centers.fromMap(centersMap)).toList());
  }
}