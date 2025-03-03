import 'package:url_launcher/url_launcher.dart'; // استيراد مكتبة لفتح الروابط الخارجية

class MapUtils {
  MapUtils._(); // مُنشئ خاص لمنع إنشاء كائنات من هذا الكلاس

  static Future<void> openMap(double latitude, double longitude) async {
    final Uri googleMapUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    } else {
      print(" Could not open the map: $googleMapUrl");
      throw 'Could not open the Map'; // في حالة الفشل
    }
  }
}

