class Specialist {
  final String id;
  final String name;
  final String imageUrl; // URL or local path for profile picture
  final String email;
  final String password;
  final String specialty;
  final String qualification;
  final String yearsOfExperience;
  final double rating;
  final List<String> sessionTimes;
  final List<String> sessionDurations; // Available durations for sessions
  bool active;

// constructor is a special function inside a class that is automatically called when you create an object from that class.
  Specialist({  //used to initialize the properties of the object.
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.password,
    required this.specialty,
    required this.qualification,
    required this.yearsOfExperience,
    required this.rating,
    required this.sessionTimes,
    required this.sessionDurations,
    this.active = false,// ensure specialists are not available until confirmed.
  });

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
List<Specialist> specialistsInfo = [//list of Specialist objects that stores information about multiple specialists.
  Specialist(//When we create an object, we use the constructor.
    id: "sp1", //creates an  (object) of the Specialist class with specific values.
    name: 'د. أحمد محمد',
    imageUrl: 'assets/specialist1.png',
    email: 'ahmed@example.com',
    password: 'password123',
    specialty: "أخصائي تخاطب",
    qualification: "دكتوراه",
    yearsOfExperience: "10 سنوات",
    rating: 4.0,
    sessionTimes: ["10:00 ص", "2:00 م", "5:00 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],

  ),
  Specialist(
    id: "sp2",
    name: 'أ. فاطمة علي',
    imageUrl: 'assets/specialist2.png',
    email: 'fatima@example.com',
    password: 'password456',
    specialty: "أخصائي نفسي",
    qualification: "ماجستير",
    yearsOfExperience: "23 سنة",
    rating: 4.6,
    sessionTimes: ["9:00 م", "8:00 م", "4:30 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],
  ),
  Specialist(
    id: "sp3",
    name: 'أ. علي يوسف',
    imageUrl: 'assets/specialist3.png',
    email: 'ali@example.com',
    password: 'password789',
    specialty: "أخصائي علاج وظيفي",
    qualification: "بكالوريوس",
    yearsOfExperience: "7 سنوات",
    rating: 5.0,
    sessionTimes: ["8:30 م", "11:00 ص", "3:00 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],
  ),
  Specialist(
    id: "sp4",
    name: 'د. ليلى حسين',
    imageUrl: 'assets/specialist4.png',
    email: 'layla@example.com',
    password: 'password012',
    specialty: "أخصائي تحليل سلوك تطبيقي",
    qualification: "دكتوراه",
    yearsOfExperience: "12 سنة",
    rating: 4.8,
    sessionTimes: ["10:00 ص", "2:00 م", "5:00 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],
  ),
  Specialist(
    id: "sp5",
    name: 'أ. يوسف عبدالله',
    imageUrl: 'assets/specialist5.jpg',
    email: 'youssef@example.com',
    password: 'password345',
    specialty: "أخصائي تخاطب",
    qualification: "ماجستير",
    yearsOfExperience: "8 سنوات",
    rating: 4.0,
    sessionTimes: ["8:30 م", "11:00 ص", "3:00 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],
  ),
  Specialist(
    id: "sp6",
    name: 'أ. سارة خالد',
    imageUrl: 'assets/specialist7.jpg',
    email: 'sara@example.com',
    password: 'password678',
    specialty: "أخصائي نفسي",
    qualification: "بكالوريوس",
    yearsOfExperience: "6 سنوات",
    rating: 5.0,
    sessionTimes: ["9:00 م", "8:00 م", "4:30 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],
  ),
  Specialist(
    id: "sp7",
    name: 'د. محمد علي',
    imageUrl: 'assets/specialist6.jpg',
    email: 'mohammed@example.com',
    password: 'password910',
    specialty: "أخصائي علاج وظيفي",
    qualification: "دكتوراه",
    yearsOfExperience: "15 سنة",
    rating: 4.7,
    sessionTimes: ["10:00 ص", "2:00 م", "5:00 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],

  ),
  Specialist(
    id: "sp8",
    name: 'أ. هند عبدالله',
    imageUrl: 'assets/specialist8.jpg',
    email: 'hend@example.com',
    password: 'password112',
    specialty: "أخصائي تحليل سلوك تطبيقي",
    qualification: "ماجستير",
    yearsOfExperience: "9 سنوات",
    rating: 4.8,
    sessionTimes: ["9:00 م", "8:00 م", "4:30 م"],
    sessionDurations: ["30 دقيقة", "1 ساعة"],
  ),
];