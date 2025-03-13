class Centers {
   int id;
   String name;
   String location;
   String description;
   String email;
   String phone;
   String imagePath;
   double latitude;
   double longitude;

  Centers({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.email,
    required this.phone,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
  });
  // Convert Supabase JSON to Dart object
  factory Centers.fromMap(Map<String, dynamic> map) {
    return Centers(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      description: map['description'],
      email: map['email'],
      phone: map['phone'],
      imagePath: map['imagePath'],
      latitude: map['latitude'].toDouble(),
      longitude: map['longitude'].toDouble(),
    );
  }

  // Convert Dart object to Supabase JSON
  Map<String, dynamic> tomap() {
    return {
      'id' : id,
      'name': name,
      'location': location,
      'description': description,
      'email': email,
      'phone': phone,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

/*
final List<Centers> centerslist = [
  Centers(
    name: 'جمعية إرادة',
    location: 'نجران',
    description:
        'جمعية إرادة التوحد جمعية تُعنى بخدمة ذوي اضطراب التوحد بمنطقة نجران وتسعى لمساعدة ذوي اضطراب التوحد وأُسرهم ودعمهم تدريباً وتأهيلاً وتعليماً ليكونوا أعضاء فاعلين في المجتمع لتحقيق ذواتهم.',
    email: '  E-tawhud@hotmail.com',
    phone: '0501345744  ',
    imagePath: "assets/center1.png",
    latitude: 17.565976958397233, //17.565976958397233, 44.212039069128764
    longitude: 44.212039069128764,
  ),
  Centers(
    name: 'مركز عبداللطيف',
    location: 'الخبر',
    description:
        'مركز متخصص في التربية الخاصة هو الوصول بالطفل ذو الإجتياجات الخاصة إلى مستوى من النضج، والإستقلالية، والإعتماد على النفس من خلال تقديم الخدمات التربوية، والتعليمية المتخصصة لذوي الاحتياجات الخاصة.',
    email: 'afac@afac.org.sa',
    phone: '0550272818',
    imagePath: "assets/center2.png",
    latitude: 26.310274,
    longitude: 50.179995, //
  ),
  Centers(
    name: 'مركز احتواء',
    location: 'الرياض',
    description:
        'قدم خدمات علاجية متنوعة مثل العلاج الوظيفي والدعم الأكاديمي والتدخل المبكر مع التأهيل النفسي والسلوكي، ولا تنحصر خدمات مركز احتواء على المستفيدين فقط بل يقدم المسانده أيضا للأسره والمجتمع ويضم نخبة من أمهر وأفضل الأطباء والأخصائيين. يقدم أحدث برامج التأهيل النفسي والسلوكي للأطفال والدعم للأسرة.',
    email: 'Info@Ehtiwa.Com',
    phone: '50 777 8904',
    imagePath: "assets/center3.png",
    latitude: 24.704823,
    longitude: 46.675137, //17.565997565666727, 44.21198682041514
  ),
  Centers(
    name: 'مركز شمعة',
    location: 'الدمام',
    description:
        'يسعى المركز إلى تقديم خدماته باستخدام أحدث الوسائل العلمية وذلك عن طريق اتباع منهج تحليل السلوك التطبيقي المعتمد عالمياً كأفضل طريقة لمعالجة حالات التوحد، وتم توظيف مجموعة من الخبراء في شتى المجالات لتقديم خدمات المركز:في مركز شمعة التوحد للتأهيل يحصل كل مستفيد عل خطة تأهيل خاصة به تبعاً لخصائصه وقدراته ومهاراته وعمره، حيث تحتوي الخطط على أهداف محددة قابلة للقياس يتم العمل على تحقيقها من خلال الجلسات المتناسبة وحاجة المستفيد وفق مرحلة التدخل المحددة وقت تسجيل المستفيد في المركز: التدخل المبكر، عمر المدرسة، التهيئة للدمج، الدمج.',
    email: ' info@shamah-autism.com.sa',
    phone: ' 0555992948 ',
    imagePath: "assets/center4.png",
    latitude: 26.432113,
    longitude: 50.028357,
    //26.432098184697235, 50.028334412444856 26.432113, 50.028357
  ),
  Centers(
    name: 'مركز التميمي',
    location: 'عنيزة',
    description:
        'مركز الشيخ علي بن عبد الله التميمي للتوحد مركز خيري يسعى لتلبية احتياجات الأشخاص ذوي التوحد وأسرهم من خلال تبني أفضل المنهجيات والنظم لجودة وشمولية الخدمات في إطار رؤية مستقبلية شاملة لإحداث تغيير إيجابي في حياتهم تمكنهم من الاندماج في المجتمع والمشاركة فيه بفاعلية.',
    email: ' tamimi@onaizah.org.sa',
    phone: ' 920020293 ',
    imagePath: "assets/center5.jpg",
    latitude: 26.090793809173423,
    longitude: 43.91821156916464,
  ), //26.090759453339324, 43.91820134958041 26.090793809173423, 43.91821156916464
];*/
