import 'package:jisser_app/model/center_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CenterService {
  final centersDB = Supabase.instance.client.from('Centers');

//create


  //read
  final stream = Supabase.instance.client.from('Centers').stream(
    primaryKey: ['id'],
  ).map((data) =>
      data.map((centersMap) => Centers.fromMap(centersMap)).toList());


}
/* // Fetches a list of centers
  Future<List<Centers>> getCenters() async {
    final response = await _supabase
        .from('centers')
        .select('*')
        .execute(); // Get a single center

    if (response.error != null) {
      throw Exception('Error fetching centers: ${response.error?.message}');
    }

    final List<dynamic> data = response.data;
    return data.map((center) => Centers.fromJson(center)).toList();
  }

  // Fetch a single center by its ID
  Future<Centers?> getCenterById(int centerId) async {
    final response = await _supabase
        .from('centers')
        .select('*')
        .eq('id', centerId)
        .single()
        .execute();

    if (response.error != null) {
      throw Exception('Error fetching center: ${response.error?.message}');
    }

    return Centers.fromJson(response.data);
  }
}*/