import 'package:flutter/material.dart';

import '../model/specialist_model.dart';
import 'Specialist_info_page.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.language, color: Colors.indigo),
          onPressed: () {
            print("Change language");
          },
        ),
        /*leading: Container(
          padding: EdgeInsets.all(7),
          child: Image.asset(
              "assets/menu.png",
          height: 20,
            width: 20,
          ),
        ),*/

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/jisserLogo.jpeg",
              height: 30,
            )
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(7),
            child: Image.asset(
              "assets/menu.png", // القائمة على اليمين
              height: 20,
              width: 20,
            ),
          ),
        ],
        /*actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          )
        ],*/
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // Reverse the scroll direction (right to left)
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  _buildCenterCard(
                      "جمعية إرادة", "assets/center1.png", "نجران"),
                  SizedBox(width: 10),
                  _buildCenterCard(
                      " مركز عبداللطيف", "assets/img.png", "الخبر"),
                  SizedBox(width: 10),
                  _buildCenterCard(
                      "مركز احتواء", "assets/center3.png", "الرياض"),
                  SizedBox(width: 10),
                  _buildCenterCard("مركز شمعة", "assets/center4.png", "الدمام"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("الأخصائيين",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF08174A)),
                textAlign: TextAlign.right),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // Reverse the scroll direction (right to left)
              child: Row(
                textDirection: TextDirection.rtl,
                children: specialistsInfo.map((specialist) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to SpecialistInfoPage and pass the selected specialist
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SpecialistInfoPage(specialist: specialist),
                        ),
                      );
                    },
                    child: _buildSpecialistCard(
                      specialist.name,
                      specialist.specialty,
                      specialist.imageUrl,
                      specialist.rating,
                      // Rating can be dynamic if you have this data in the specialist object
                      specialist.qualification,
                      specialist.yearsOfExperience,
                      specialist.sessionTimes,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            _buildInfoCard("ما هو اضطراب طيف التوحد؟", Color(0xFFA3C7EB),
                "assets/puzzle.png"),
            _buildInfoCard("التشخيص المبكر: مفتاح للتدخل الفعال وتحسين النتائج",
                Color(0xFFF0E392), "assets/puzzle.png"),
            _buildInfoCard("دور الأسرة في رحلة علاج طفل التوحد",
                Color(0xFF374553), "assets/puzzle.png"),
            _buildInfoCard("10 نصائح لتواصل أفضل مع طفل مصاب بالتوحد",
                Color(0xFFF0C9AC), "assets/puzzle.png"),
            _buildInfoCard("ما هو اضطراب طيف التوحد؟", Color(0xFFA3C7EB),
                "assets/puzzle.png"),
            _buildInfoCard("التشخيص المبكر: مفتاح للتدخل الفعال وتحسين النتائج",
                Color(0xFFF0E392), "assets/puzzle.png"),
            _buildInfoCard("دور الأسرة في رحلة علاج طفل التوحد",
                Color(0xFF374553), "assets/puzzle.png"),
            _buildInfoCard("10 نصائح لتواصل أفضل مع طفل مصاب بالتوحد",
                Color(0xFFF0C9AC), "assets/puzzle.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterCard(String title, String imagePath, String location) {
    return Container(
      width: 145,
      padding: EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 100, width: 100),
          SizedBox(height: 19),
          Align(
            alignment: Alignment.centerRight,
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF08174A))),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.location_on, color: Colors.grey, size: 17),
              Text(location,
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialistCard(
      String name,
      String specialty,
      String imagePath,
      double rating,
      String qualification,
      String yearsOfExperience,
      List<String> sessionTimes) {
    // Create a Specialist object for each card
    Specialist specialist = Specialist(
      id: "",
      // Generate or leave empty for now
      name: name,
      imageUrl: imagePath,
      email: '',
      // Optional
      password: '',
      // Optional
      specialty: specialty,
      qualification: qualification,
      // Optional
      yearsOfExperience: yearsOfExperience,
      // Optional
      rating: rating,
      sessionTimes: sessionTimes,
    );
    return GestureDetector(
      onTap: () {
        // Navigate to SpecialistInfoPage and pass the Specialist object
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecialistInfoPage(specialist: specialist),
          ),
        );
      },
      child: Container(
        width: 110,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.grey, width: 1), // إضافة إطار أسود
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            SizedBox(height: 5),
            Text(name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(specialty,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 14),
                Text("$rating", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String text, Color color, String imagePath) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // يجعل الصورة تأتي أولًا على اليمين
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17),
              textAlign: TextAlign.right, // التأكد من محاذاة النص لليمين
            ),
          ),
          SizedBox(width: 10),
          Image.asset(imagePath, height: 50, width: 50),
        ],
      ),
    );
  }
}
