import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 0.0;

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تقييمك هو',
            textAlign: TextAlign.right, // Right-align the title
          ),
          content: Text(
            'تقيمك : $_rating',
            textAlign: TextAlign.right, // Right-align the content
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.blueAccent),
        onPressed: () {
          Navigator.pop(context);//الرجوع إلى الصفحة السابقة
        },
      ),

      actions: [SizedBox(width: 48)], // لتوازن العناصر في الشريط العلوي
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/jisserLogo.jpeg',
              width: 140,
              height: 140,

            ),
            Text(
              'تقييم الجلسه',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.right, // Right-align the text
            ),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showRatingDialog,
              child: Text('ارسال تقييمك'),
            ),
          ],
        ),
      ),
    );
  }
}


