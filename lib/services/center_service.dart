import 'package:jisser_app/model/center_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CenterService {
  final centersDB = Supabase.instance.client;

//create


  //read

  final stream = Supabase.instance.client.from('Centers').stream(
    primaryKey: ['id'],
  ).map((data) =>
      data.map((centersMap) => Centers.fromMap(centersMap)).toList());


}
