import 'package:flutter/material.dart';

class SpecialistHomePage extends StatelessWidget {
  const SpecialistHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl, 
        child: Scaffold(
         // backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
              onPressed: () {},
            ),
            title: Center(
            child: Image.asset(
            'assets/jisserLogo.jpeg',
              width: 40,
              height: 40,
            ),
          ),
          actions: [SizedBox(width: 48)], // توازن لموائمة الصورة في المنتصف
        ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/specialist2.png'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'د. سهى هاني السعدي',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'أخصائي نفسي',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 44),
                InfoRow(
                    icon: Icons.school,
                    label: 'المؤهل العلمي',
                    value: 'ماجستير تربية خاصة - USA'),
                InfoRow(icon: Icons.history, label: 'الخبرة', value: '23 سنة'),
                InfoRow(
                    icon: Icons.menu_book,
                    label: 'تقديم الجلسات',
                    value: 'كتابية'),
                SizedBox(height: 24),
                Text(
                  'وقت الجلسة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SessionTimeButton(label: '5:00'),
                    SessionTimeButton(label: '6:00'),
                    SessionTimeButton(label: '8:00'),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'مدة الجلسة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SessionDurationButton(label: '30 دقيقة/ 150 ريال'),
                    SessionDurationButton(label: '1 ساعة/ 250 ريال'),
                  ],
                ),
                const SizedBox(height: 80,),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'حجز الجلسة',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          SizedBox(width: 8),
          Text('$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          Expanded(
            child: Text(value,
                style: TextStyle(
                  color: Colors.grey[700],
                )),
          ),
        ],
      ),
    );
  }
}

class SessionTimeButton extends StatelessWidget {
  final String label;

  const SessionTimeButton({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label, style: TextStyle(color:Color(0xFF071164))),
    );
  }
}

class SessionDurationButton extends StatelessWidget {
  final String label;

  const SessionDurationButton({required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label, style: TextStyle(color: Color(0xFF071164))),
    );
  }
}
