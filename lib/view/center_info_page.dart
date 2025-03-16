import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jisser_app/control/map_utils.dart';

import '../model/center_model.dart';
import '../services/center_service.dart'; // استيراد أداة فتح الخرائط

class CenterInfoPage extends StatefulWidget {
  const CenterInfoPage({super.key});

  @override
  State<CenterInfoPage> createState() => _CenterInfoPageState();
}

class _CenterInfoPageState extends State<CenterInfoPage> {
 final centersDB = CenterService();
final centerController = TextEditingController();
  

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
              'assets/jisserLogo.jpeg',
              // إدراج صورة الشعار في منتصف شريط التطبيق
              width: 40,
              height: 40,
            ),
          ),
          actions: [SizedBox(width: 48)], // توازن لموائمة الصورة في المنتصف
        ),
        body: StreamBuilder<List<Centers>>(
          stream:  CenterService().getCentersStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            // Check if the data is not empty
            if (snapshot.data!.isEmpty) {
              return Center(child: Text('No centers available.'));
            }

            // Use a hardcoded value for centerId, for example 1:
            final center = snapshot.data!.firstWhere(
                  (c) => c.id == 1, // Hardcoded centerId value
              orElse: () => Centers(
                id: 0,
                name: 'غير موجود',
                location: '',
                description: '',
                email: '',
                phone: '',
                imagePath: '',
                latitude: 0,
                longitude: 0,
              ),
            );

            if (center.id == 0) {
              return Center(child: Text('المركز غير موجود'));
            }

            return  SingleChildScrollView(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: center.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                            center.name,//here
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
                              Text(center.location,//here
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                          SizedBox(height: 16),

                          // وصف الجمعية
                          Text(
                            center.description,//here
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),

                          // معلومات الاتصال
                          Row(
                            children: [
                              Icon(Icons.email, color: Colors.indigo),
                              SizedBox(width: 5),
                              Text(center.email,//here
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.indigo),
                              SizedBox(width: 5),
                              Text(center.phone,//here
                                  style: TextStyle(fontSize: 16)),
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
                                      center.latitude, center.longitude);//here
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
            );
          },
        ),
      ),
    );
  }
}
