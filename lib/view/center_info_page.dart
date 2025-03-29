import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jisser_app/control/map_utils.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';

import '../model/center_model.dart';
import '../services/center_service.dart'; // استيراد أداة فتح الخرائط

class CenterInfoPage extends StatefulWidget {
  final Centers centers;
  const CenterInfoPage({super.key, required this.centers});

  @override
  State<CenterInfoPage> createState() => _CenterInfoPageState();
}

class _CenterInfoPageState extends State<CenterInfoPage> {
  final centersDB = CenterService();
  final centerController = TextEditingController();

  late String url = widget.centers.imagePath;
  late String fixedUrl = url.replaceFirst("https:/", "https://");
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
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
          actions: const [
            SizedBox(width: 48)
          ], // توازن لموائمة الصورة في المنتصف
        ),
        body: StreamBuilder<List<Centers>>(
          stream: CenterService().getCentersStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            // Check if the data is not empty
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No centers available.'));
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
              return const Center(child: Text('المركز غير موجود'));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: CachedNetworkImage(
                      imageUrl: fixedUrl,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
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
                            widget.centers.name, //here
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF071164),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // الموقع
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.grey),
                              const SizedBox(width: 5),
                              Text(widget.centers.location, //here
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // وصف الجمعية
                          Text(
                            widget.centers.description, //here
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),

                          // معلومات الاتصال
                          GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: widget.centers.email));
                              CustomSnackBar.snackBarwidget(
                                  context: context,
                                  color: Colors.green,
                                  text: S.of(context).coping);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.email, color: Colors.indigo),
                                const SizedBox(width: 5),
                                Text(widget.centers.email, //here
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.indigo),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: widget.centers.phone));
                                  CustomSnackBar.snackBarwidget(
                                      context: context,
                                      color: Colors.green,
                                      text: S.of(context).coping);
                                },
                                child: Text(widget.centers.phone, //here
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),

                          const SizedBox(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10)),
                                onPressed: () {
                                  MapUtils.openMap(widget.centers.latitude,
                                      widget.centers.longitude); //here
                                },
                                child: const Icon(Icons.location_on_outlined,
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
