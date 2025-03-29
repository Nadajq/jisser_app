
class Specialist {
  final String id;
  final String name;
  final String imageUrl;
  final String pdfUrl;
  final String email;
  final String specialty;
  final String qualification;
  final String yearsOfExperience;
  final int? rating;
  final List<dynamic>? sessionTimes;
  final List<dynamic>? sessionDurations;
  bool? active;
  final String date;

  Specialist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pdfUrl,
    required this.email,
    required this.specialty,
    required this.qualification,
    required this.yearsOfExperience,
    required this.rating,
    required this.sessionTimes,
    required this.sessionDurations,
    this.active = false,
    required this.date,
  });

  factory Specialist.fromMap(Map<String, dynamic> data) {
    return Specialist(
      id: data['id'],
      name: data['name'],
      imageUrl: data['image_url'],
      pdfUrl: data['pdf_url'],
      email: data['email'],
      specialty: data['specialty'],
      qualification: data['qualification'],
      yearsOfExperience: data['years_of_experience'].toString(),
      rating: data['rating'],
      sessionTimes: data['session_times'],
      sessionDurations: data['session_duration'],
      active: data['active'],
      date: data['date'],
    );

  }

  static List<String> specialties = [
    "أخصائي تخاطب",
    "أخصائي علاج وظيفي",
    "أخصائي تحليل سلوك تطبيقي",
    "أخصائي نفسي",
  ];

  static List<String> qualifications = [
    "بكالوريوس",
    "ماجستير",
    "دكتوراه",
  ];
}

List<Specialist> specialistsInfo = [
  // list of Specialist objects that stores information about multiple specialists.
  Specialist(//When we create an object, we use the constructor.
    id: "sp1",
    date :"", //creates an  (object) of the Specialist class with specific values.
    name: 'د. أحمد محمد',
    imageUrl: 'assets/specialist1.png',
    email: 'ahmed@example.com',
    specialty: "أخصائي تخاطب",
    qualification: "دكتوراه",
    yearsOfExperience: "10 سنوات",
    rating: 4,
    pdfUrl: '',
    sessionTimes: ["10:00 ص", "2:00 م", "5:00 م"],
    sessionDurations: ["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],

  ),
  Specialist(
    id: "sp2",
    date :"",
    name: 'أ. فاطمة علي',
    imageUrl: 'assets/specialist2.png',
    email: 'fatima@example.com',
    specialty: "أخصائي نفسي",
    qualification: "ماجستير",
    yearsOfExperience: "23 سنة",
    rating: 4,
    pdfUrl: '',
    sessionTimes: ["9:00 م", "8:00 م", "4:30 م"],
    sessionDurations: ["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],
  ),
  Specialist(
    id: "sp3",
    date :"",
    name: 'أ. علي يوسف',
    imageUrl: 'assets/specialist3.png',
    email: 'ali@example.com',
    specialty: "أخصائي علاج وظيفي",
    qualification: "بكالوريوس",
    yearsOfExperience: "7 سنوات",
    rating: 5,
    pdfUrl: '',
    sessionTimes: ["8:30 م", "11:00 ص", "3:00 م"],
    sessionDurations: ["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],
  ),
  Specialist(
    id: "sp4",
    date :"",
    name: 'د. ليلى حسين',
    imageUrl: 'assets/specialist4.png',
    email: 'layla@example.com',
    specialty: "أخصائي تحليل سلوك تطبيقي",
    qualification: "دكتوراه",
    yearsOfExperience: "12 سنة",
    rating: 4,
    pdfUrl: '',
    sessionTimes: ["10:00 ص", "2:00 م", "5:00 م"],
    sessionDurations:["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],
  ),
  Specialist(
    id: "sp5",
    date :"",
    name: 'أ. يوسف عبدالله',
    imageUrl: 'assets/specialist5.jpg',
    email: 'youssef@example.com',
    specialty: "أخصائي تخاطب",
    qualification: "ماجستير",
    yearsOfExperience: "8 سنوات",
    rating: 4,
    pdfUrl: '',
    sessionTimes: ["8:30 م", "11:00 ص", "3:00 م"],
    sessionDurations: ["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],
  ),
  Specialist(
    id: "sp6",
    date :"",
    name: 'أ. سارة خالد',
    imageUrl: 'assets/specialist7.jpg',
    email: 'sara@example.com',
    specialty: "أخصائي نفسي",
    qualification: "بكالوريوس",
    yearsOfExperience: "6 سنوات",
    rating: 5,
    pdfUrl: '',
    sessionTimes: ["9:00 م", "8:00 م", "4:30 م"],
    sessionDurations: ["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],
  ),
  Specialist(
    id: "sp7",
    date :"",
    name: 'د. محمد علي',
    imageUrl: 'assets/specialist6.jpg',
    email: 'mohammed@example.com',
    specialty: "أخصائي علاج وظيفي",
    qualification: "دكتوراه",
    yearsOfExperience: "15 سنة",
    rating: 4,
    pdfUrl: '',
    sessionTimes: ["10:00 ص", "2:00 م", "5:00 م"],
    sessionDurations: ["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],

  ),
  Specialist(
    id: "sp8",
    date :"",
    name: 'أ. هند عبدالله',
    imageUrl: 'assets/specialist8.jpg',
    email: 'hend@example.com',
    specialty: "أخصائي تحليل سلوك تطبيقي",
    qualification: "ماجستير",
    yearsOfExperience: "9 سنوات",
    rating: 4,
    pdfUrl: '',
    sessionTimes: ["9:00 م", "8:00 م", "4:30 م"],
    sessionDurations:["30 دقيقة/ 75 ر.س", "1 ساعة/ 150 ر.س"],
  ),
];