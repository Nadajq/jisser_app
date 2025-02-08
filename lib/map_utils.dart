import 'package:url_launcher/url_launcher.dart'; // استيراد مكتبة لفتح الروابط الخارجية
//كلاس يحتوي على دالة لفتح الخرائط في جوجل ماب
class MapUtils {
  MapUtils._();// مُنشئ خاص لمنع إنشاء كائنات من هذا الكلاس
  static Future<void> openMap(// دالة لفتح موقع معين في خرائط جوجل
    String Latitude,
    //double Longitude
  ) async {
   // إنشاء رابط لفتح الموقع باستخدام إحداثيات خط العرض
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$Latitude";
        // التحقق مما إذا كان يمكن فتح الرابط
    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);فتح الرابط
    } else {
      throw 'Could not open the Map';// في حالة الفشل
    }
  }
}
