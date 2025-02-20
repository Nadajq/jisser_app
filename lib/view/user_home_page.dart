import 'package:flutter/material.dart';
import 'package:jisser_app/view/blog_info_page.dart';

import '../model/blogs_model.dart';
import '../model/center_model.dart';
import '../model/specialist_model.dart';
import 'Specialist_info_page.dart';
import 'center_info_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

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
            padding: const EdgeInsets.all(7),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,// Allows horizontal scrolling.
              reverse: true, // Reverse the scroll direction (right to left)
              child: Row(
                textDirection: TextDirection.rtl,
                children: centerslist.map((centers) {// Go through each center in centerslist and create a widget for it
                  return GestureDetector(
                    onTap: () {
                      // Navigate to CenterInfoPage and pass the selected center
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CenterInfoPage(centers: centers),
                        ),
                      );
                    },
                    child: _buildCenterCard(centers.name,// Calls a function that creates a card widget displaying center details.
                      centers.location,
                      centers.description,
                      centers.email,
                      centers.phone,
                      centers.imagePath,
                      centers.map,),
                  );
                }).toList(),// Convert the mapped widgets into a list
              ),
            ),
            const SizedBox(height: 20),
            const Text("الأخصائيين",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF08174A)),
                textAlign: TextAlign.right),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // Reverse the scroll direction (right to left)
              child: Row(
                textDirection: TextDirection.rtl,
                children: specialistsInfo.map((specialist) {// Go through each center in specialistsInfo list and create a widget for it
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
                    child: _buildSpecialistCard(// Calls a function that creates a card widget displaying Specialist details.
                      specialist.name,
                      specialist.specialty,
                      specialist.imageUrl,
                      specialist.rating,
                      specialist.qualification,
                      specialist.yearsOfExperience,
                      specialist.sessionTimes,
                      specialist.sessionDurations,
                      specialist.active,
                    ),
                  );
                }).toList(),// Convert the mapped widgets into a list
              ),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: blogsList.map((blog) {// Go through each center in blogslist and create a widget for it
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogInfoPage(blogs: blog),
                        ),
                      );
                    },// Calls a function that creates a card widget displaying blog details.
                    child: _buildInfoCard(blog.title,  blog.bgcolor ,  "assets/puzzle.png", blog.content),
                  );
                }).toList(),// Convert the mapped widgets into a list
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterCard(//function creates and returns a card widget displaying center details.
      String name,
      String location,
      String description,
      String email,
      String phone,
      String imagePath,
      String map) {
    // Create a Center object for each card
    Centers centers = Centers(
      name: name,
      location: location,
      description: description,
      email: email,
      phone: phone,
      imagePath: imagePath,
      map: map,
    );

    return GestureDetector(
        onTap: () {
      // Navigate to CenterInfoPage and pass the Center object
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CenterInfoPage(centers: centers),
        ),
      );
    },
    child: Container(
      width: 145,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26),
        boxShadow: const [
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
          Image.asset(centers.imagePath, height: 100, width: 100),
          const SizedBox(height: 19),
          Align(
            alignment: Alignment.centerRight,
            child: Text(centers.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF08174A))),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 17),
              Text(centers.location,
                  style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildSpecialistCard(//function creates and returns a card widget displaying Specialist details.
      String name,
      String specialty,
      String imagePath,
      double rating,
      String qualification,
      String yearsOfExperience,
      List<String> sessionTimes,
      List<String> sessionDurations,
      bool active,
      ) {
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
      sessionDurations: sessionDurations,
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
        padding: const EdgeInsets.all(8),
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
            const SizedBox(height: 5),
            Text(name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(specialty,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 14),
                Text("$rating", style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
//function creates and returns a card widget displaying blog details.
  Widget _buildInfoCard(String title, Color? bgcolor, String imagePath , String content) {
    Color finalBgColor = bgcolor ?? Colors.blue; // Default color if null

    Blogs blogs = Blogs(
        id: '',
        title: title,
        content: content,
      bgcolor: finalBgColor, // Use the valid color here
    );
    return GestureDetector(
        onTap: () {
      // Navigate to BlogInfoPage and pass the blogs object
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlogInfoPage(blogs: blogs),
        ),
      );
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: finalBgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
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
              blogs.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17),
              textAlign: TextAlign.right, // التأكد من محاذاة النص لليمين
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(imagePath, height: 50, width: 50),
        ],
      ),
    ),
    );
  }
}
