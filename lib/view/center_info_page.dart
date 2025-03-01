import 'package:flutter/material.dart';
import 'package:jisser_app/control/map_utils.dart';

import '../model/center_model.dart'; // استيراد أداة فتح الخرائط

class CenterInfoPage extends StatelessWidget {
  final Centers centers;
  const CenterInfoPage({super.key, required this.centers});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.blueAccent, size: 28), // أيقونة الرجوع للخلف
            onPressed: () {
              // تنفيذ الرجوع للخلف
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Image.asset(
              'assets/jisserLogo.jpeg', // إدراج صورة الشعار في منتصف شريط التطبيق
              width: 40,
              height: 40,
            ),
          ),
          actions: [SizedBox(width: 48)], // توازن لموائمة الصورة في المنتصف
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                centers.imagePath, //
                width: double.infinity,
                //height: 250,
                // fit: BoxFit.cover,
              ),

              // المحتوى النصي والمعلومات
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Directionality(
                  // جعل النصوص من اليمين إلى اليسار
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        centers.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF071164),
                        ),
                      ),

                      SizedBox(height: 8),

                      // الموقع
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(centers.location,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                      SizedBox(height: 16),

                      // وصف الجمعية
                      Text(
                        centers.description,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),

                      // معلومات الاتصال
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.indigo),
                          SizedBox(width: 5),
                          Text(centers.email, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.indigo),
                          SizedBox(width: 5),
                          Text(centers.phone, style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Align(
                          alignment: Alignment
                              .bottomLeft, // وضع الزر في الزاوية اليسرى
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10)),
                            onPressed: () {
                              MapUtils.openMap(
                                  centers.latitude, centers.longitude);
                            },
                            child: Icon(Icons.location_on_outlined,
                                color: Color(0xffffffff), size: 50),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
