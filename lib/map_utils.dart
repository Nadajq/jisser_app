import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();
  static Future<void> openMap(
    String Latitude,
    //double Longitude,
  ) async {
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$Latitude";
    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      throw 'Could not open the Map';
    }
  }
}