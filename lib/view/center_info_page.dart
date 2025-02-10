import 'package:flutter/material.dart';
import 'package:jisser_app/map_utils.dart'; // استيراد أداة فتح الخرائط


class CenterInfoPage extends StatelessWidget {
  const CenterInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,

       home: Directionality(
         // جعل كل النصوص من اليمين إلى اليسار
         textDirection: TextDirection.rtl,
         child: AutismAssociationScreen(),
          // الانتقال إلى صفحة عرض المعلومات

       ),
     );
   }
 }
// الشاشة الرئيسية التي تعرض تفاصيل
 class AutismAssociationScreen extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.white,
         leading: IconButton(
           icon: Icon(Icons.arrow_back, color: Colors.blueAccent, size: 28),// أيقونة الرجوع للخلف
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
               'assets/center1.png', //
               width: double.infinity,
               height: 250,
               fit: BoxFit.cover,
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
                       'جمعية إرادة التوحد',
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
                         Text('نجران', style: TextStyle(fontSize: 16,)),
                       ],
                     ),
                     SizedBox(height: 16),

                     // وصف الجمعية
                     Text(
                       'جمعية إرادة التوحد جمعية تُعنى بخدمة ذوي اضطراب التوحد بمنطقة نجران، '
                       'وتسعى لمساعدة ذوي اضطراب التوحد وأسرهم ودعمهم تدريبًا وتأهيلاً وتعليمًا ليكونوا أعضاء فاعلين في المجتمع لتحقيق ذواتهم.',
                       textAlign: TextAlign.right,
                       style: TextStyle(fontSize: 16),
                     ),
                     SizedBox(height: 20),

                     // معلومات الاتصال
                     Row(
                       children: [
                         Icon(Icons.email, color: Colors.indigo),
                         SizedBox(width: 5),
                         Text('ew@gmail.com', style: TextStyle(fontSize: 16)),
                       ],
                     ),
                     SizedBox(height: 10),

                     Row(
                       children: [
                         Icon(Icons.phone, color: Colors.indigo),
                         SizedBox(width: 5),
                         Text('054 555 7819', style: TextStyle(fontSize: 16)),
                       ],
                     ),

                     SizedBox(height: 10,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20,),
                       child: Align(
                         alignment: Alignment.bottomLeft, // وضع الزر في الزاوية اليسرى
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.indigo,
                               padding: EdgeInsets.symmetric(
                                   horizontal: 10, vertical: 10)),
                           onPressed: () {
                               MapUtils.openMap("https://g.co/kgs/KKyFCie");
                           }, // فتح الموقع على الخرائط
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
     );
   }
 }