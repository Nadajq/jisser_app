class Specialist {
  String id;
  String name;
  String imageUrl; // URL or local path for profile picture
  String email;
  String password;
  String specialty;
  String qualification;
  String yearsOfExperience;

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
    id: "", //creates an  (object) of the Specialist class with specific values.
    name: 'د. أحمد محمد',
    imageUrl: 'assets/specialist1.png',
    email: 'ahmed@example.com',
    password: 'password123',
    specialty: "أخصائي تخاطب",
    qualification: "دكتوراه",
    yearsOfExperience: "10 سنوات",
  ),
  Specialist(
    id: "",
    name: 'أ. فاطمة علي',
    imageUrl: 'assets/specialist2.png',
    email: 'fatima@example.com',
    password: 'password456',
    specialty: "أخصائي نفسي ",
    qualification: " ماجستير تربيه خاصه توحد USA - دبلوم ارشاد اسري",
    yearsOfExperience: "23 سنة",
  ),
  Specialist(
    id: "",
    name: 'أ. علي يوسف',
    imageUrl: 'assets/specialist3.png',
    email: 'ali@example.com',
    password: 'password789',
    specialty: "أخصائي علاج وظيفي",
    qualification: "بكالوريوس",
    yearsOfExperience: "7 سنوات",
  ),
  Specialist(
    id: "",
    name: 'د. ليلى حسين',
    imageUrl: 'assets/specialist4.png',
    email: 'layla@example.com',
    password: 'password012',
    specialty: "أخصائي تحليل سلوك تطبيقي",
    qualification: "دكتوراه",
    yearsOfExperience: "12 سنة",
  ),
  Specialist(
    id: "",
    name: 'أ. يوسف عبدالله',
    imageUrl: 'assets/specialist5.jpg',
    email: 'youssef@example.com',
    password: 'password345',
    specialty: "أخصائي تخاطب",
    qualification: "ماجستير",
    yearsOfExperience: "8 سنوات",
  ),
  Specialist(
    id: "",
    name: 'أ. سارة خالد',
    imageUrl: 'assets/specialist7.jpg',
    email: 'sara@example.com',
    password: 'password678',
    specialty: "أخصائي نفسي",
    qualification: "بكالوريوس",
    yearsOfExperience: "6 سنوات",
  ),
  Specialist(
    id: "",
    name: 'د. مصطفى إبراهيم',
    imageUrl: 'assets/specialist6.jpg',
    email: 'mustafa@example.com',
    password: 'password910',
    specialty: "أخصائي علاج وظيفي",
    qualification: "دكتوراه",
    yearsOfExperience: "15 سنة",
  ),
  Specialist(
    id: "",
    name: 'أ. هند عبدالله',
    imageUrl: 'assets/specialist8.jpg',
    email: 'hend@example.com',
    password: 'password112',
    specialty: "أخصائي تحليل سلوك تطبيقي",
    qualification: "ماجستير",
    yearsOfExperience: "9 سنوات",
  ),
];