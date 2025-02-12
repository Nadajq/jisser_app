class center {
  final String name;
  final String location;
  final String description;
  final String email;
  final String phone;
  final String imagePath;
  final String Map;

  center({
    required this.name,
    required this.location,
    required this.description,
    required this.email,
    required this.phone,
    required this.imagePath,
    required this.Map,

  });

  class CentersListScreen extends StatelessWidget {
    final List<CenterModel> centers = [
      CenterModel(
        name: 'مركز عبداللطيف الفوزان للتوحد',
        location: 'الخبر',
        description: 'مركز متخصص في التربية الخاصة هو الوصول بالطفل ذو الإجتياجات الخاصة إلى مستوى من النضج، والإستقلالية، والإعتماد على النفس من خلال تقديم الخدمات التربوية، والتعليمية المتخصصة لذوي الاحتياجات الخاصة.',
        email: 'afac@afac.org.sa',
        phone: '0550272818',
        imagePath:"assets/center2.png",
        Map:"https://g.co/kgs/7E3Wbgm"

      ),
      CenterModel(
        name: 'مركز احتواء',
        location: 'الرياض',
        description: 'قدم خدمات علاجية متنوعة مثل العلاج الوظيفي والدعم الأكاديمي والتدخل المبكر مع التأهيل النفسي والسلوكي، ولا تنحصر خدمات مركز احتواء على المستفيدين فقط بل يقدم المسانده أيضا للأسره والمجتمع ويضم نخبة من أمهر وأفضل الأطباء والأخصائيين. يقدم أحدث برامج التأهيل النفسي والسلوكي للأطفال والدعم للأسرة.',
        email: 'Info@Ehtiwa.Com',
        phone: '50 777 8904',
        imagePath:"assets/center3.png",
        Map:"https://g.co/kgs/jyoFvCS"

      ),
      CenterModel(
        name: 'مركز شمعة',
        location: 'جدة',
        description: 'يسعى المركز إلى تقديم خدماته باستخدام أحدث الوسائل العلمية وذلك عن طريق اتباع منهج تحليل السلوك التطبيقي المعتمد عالمياً كأفضل طريقة لمعالجة حالات التوحد، وتم توظيف مجموعة من الخبراء في شتى المجالات لتقديم خدمات المركز:

                      في مركز شمعة التوحد للتأهيل يحصل كل مستفيد عل خطة تأهيل خاصة به تبعاً لخصائصه وقدراته ومهاراته وعمره، حيث تحتوي الخطط على أهداف محددة قابلة للقياس يتم العمل على تحقيقها من خلال الجلسات المتناسبة وحاجة المستفيد وفق مرحلة التدخل المحددة وقت تسجيل المستفيد في المركز: التدخل المبكر، عمر المدرسة، التهيئة للدمج، الدمج..',
        email: ' info@shamah-autism.com.sa',
        phone: ' 0555992948 ',
        imagePath:"assets/center4.png",
        Map:"https://g.co/kgs/zGW4K7f"

      ),
    ];

