import 'package:flutter/material.dart';

// الصفحة الرئيسية للطبيب المتخصص
class SpecialistHomePage extends StatefulWidget {
  const SpecialistHomePage({Key? key}) : super(key: key);

  @override
  _SpecialistHomePageState createState() => _SpecialistHomePageState();
}

// الفئة المسؤولة عن الحالة والتفاعل مع واجهة المستخدم
class _SpecialistHomePageState extends State<SpecialistHomePage> {
  // متغيرات لحفظ الخيارات المحددة
  String _selectedTime = "5:00 م";
  String _selectedDuration = "30 دقيقة/150 ريال";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // لضبط اتجاه النص والعناصر من اليمين إلى اليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
            onPressed: () {},
          ),
          title: Center(
            child: Image.asset(
              'assets/jisserLogo.jpeg', // شعار التطبيق
              width: 40,
              height: 40,
            ),
          ),
          actions: [SizedBox(width: 48)], // لتوازن العناصر في الشريط العلوي
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // محاذاة من اليمين
            children: [
              // صورة ومعلومات الطبيب
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/specialist2.png'),
                  ),
                  SizedBox(width: 16), // مسافة بين الصورة والنص
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'د. سهى هاني السعدي',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF546E78),
                        ),
                      ),
                      SizedBox(height: 8), // مسافة بين النصوص
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
              SizedBox(height: 24), // مسافة بين الأقسام

              // معلومات إضافية
              InfoRow(
                icon: Icons.school,
                label: 'المؤهل العلمي',
                value: 'ماجستير تربية خاصة - USA',
              ),
              InfoRow(icon: Icons.history, label: 'الخبرة', value: '23 سنة'),
              InfoRow(
                icon: Icons.menu_book,
                label: 'تقديم الجلسات',
                value: 'كتابية',
              ),
              SizedBox(height: 24), // مسافة بين الأقسام

              // وقت الجلسة
              Text(
                'وقت الجلسة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                // أزرار اختيار وقت الجلسة
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRadioButton("5:00 م", _selectedTime, (value) {
                    setState(() {
                      _selectedTime = value!;
                    });
                  }),
                  buildRadioButton("6:00 م", _selectedTime, (value) {
                    // تغيير القيمة عند الاختيار
                    setState(() {
                      _selectedTime = value!;
                    });
                  }),
                  buildRadioButton("8:00 م", _selectedTime, (value) {
                    setState(() {
                      _selectedTime = value!;
                    });
                  }),
                ],
              ),

              SizedBox(height: 24), // مسافة بين الأقسام

              // مدة الجلسة
              Text(
                'مدة الجلسة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRadioButton("30 دقيقة/150 ريال", _selectedDuration,
                      (value) {
                    setState(() {
                      _selectedDuration = value!;
                    });
                  }),
                  buildRadioButton("1 ساعة/250 ريال", _selectedDuration,
                      (value) {
                    setState(() {
                      _selectedDuration = value!;
                    });
                  }),
                ],
              ),

              SizedBox(height: 24), // مسافة بين الأقسام

              // زر الحجز
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // إضافة الحجز
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // زوايا مستديرة
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
      ),
    );
  }

// دالة لإنشاء زر اختيار
  Widget buildRadioButton(
      String text, String groupValue, Function(String?) onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: text,
          groupValue: groupValue, // القيمة الحالية للمجموعة
          onChanged: onChanged, // الإجراء عند التغيير
        ),
        Text(text), // النص بجانب زر الاختيار
      ],
    );
  }
}

// ويدجت مخصصة لعرض معلومات الطبيب
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
      padding: const EdgeInsets.symmetric(vertical: 8.0), // حواف عمودية
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          SizedBox(width: 8),
          Text('$label: ', // النص الرئيسي
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          Expanded(
            child: Text(value, // النص المرافق
                style: TextStyle(
                  color: Colors.grey[700],
                )),
          ),
        ],
      ),
    );
  }
}
