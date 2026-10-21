import 'project_media.dart';

class Bilingual {
  const Bilingual(this.en, this.ar);
  final String en;
  final String ar;
  String inLanguage(bool arabic) => arabic ? ar : en;
}

const tagTranslations = {
  'News': Bilingual('News', 'أخبار'),
  'Notifications': Bilingual('Notifications', 'إشعارات'),
  'Marketplace': Bilingual('Marketplace', 'سوق إلكتروني'),
  'Payments': Bilingual('Payments', 'مدفوعات'),
  'Mobile': Bilingual('Mobile', 'موبايل'),
  'Real estate': Bilingual('Real estate', 'عقارات'),
};

abstract final class Copy {
  static const name = Bilingual('Abdelrahman Amr', 'عبدالرحمن عمرو');
  static const work = Bilingual('Selected work', 'أعمال مختارة');
  static const experience = Bilingual('Experience', 'الخبرات');
  static const about = Bilingual('About', 'نبذة عني');
  static const contact = Bilingual('Let’s talk', 'تواصل معي');
  static const role = Bilingual(
    'Senior Flutter Developer at digitalH',
    'مطور Flutter أول لدى digitalH',
  );
  static const hero = Bilingual(
    'Mobile products.\nThoughtful engineering.',
    'تطبيقات موبايل.\nوهندسة تهتم بالتفاصيل.',
  );
  static const intro = Bilingual(
    'I’m Abdelrahman, a software engineer in Cairo. I build and maintain Flutter applications for financial services, e-commerce, news, and service platforms.',
    'أنا عبدالرحمن، مهندس برمجيات مقيم في القاهرة. أطور وأصون تطبيقات Flutter في مجالات الخدمات المالية والتجارة الإلكترونية والأخبار ومنصات الخدمات.',
  );
  static const viewWork = Bilingual('Explore my work', 'استعرض أعمالي');
  static const cv = Bilingual('View CV', 'السيرة الذاتية');
  static const selectedIntro = Bilingual(
    'A closer look at the products I’ve contributed to.',
    'نظرة أقرب إلى المنتجات التي ساهمت في تطويرها.',
  );
  static const readProject = Bilingual('Explore project', 'تفاصيل المشروع');
  static const product = Bilingual('The product', 'عن المنتج');
  static const contribution = Bilingual('My contribution', 'مساهمتي');
  static const features = Bilingual('Product highlights', 'أبرز مزايا المنتج');
  static const gallery = Bilingual('Product screens', 'صور التطبيق');
  static const close = Bilingual('Close project', 'إغلاق المشروع');
  static const store = Bilingual('View app', 'عرض التطبيق');
  static const source = Bilingual('Explore code', 'استعرض الكود');
  static const approach = Bilingual(
    'Clear boundaries.\nMaintainable applications.',
    'مسؤوليات واضحة.\nوتطبيقات قابلة للصيانة.',
  );
  static const approachBody = Bilingual(
    'My work connects mobile interfaces with backend services. I focus on understandable state management, clear architecture, and collaboration with backend and QA teams through delivery and maintenance.',
    'يربط عملي واجهات الموبايل بالخدمات الخلفية. أهتم بإدارة واضحة لحالة التطبيق، وبنية منظمة، والتعاون مع فرق الباك إند واختبار الجودة خلال التطوير والصيانة.',
  );
  static const education = Bilingual(
    'BSc Computer Science · Ain Shams University',
    'بكالوريوس علوم الحاسب · جامعة عين شمس',
  );
  static const contactTitle = Bilingual(
    'Have a mobile product\nin mind?',
    'لديك فكرة\nلتطبيق موبايل؟',
  );
  static const contactBody = Bilingual(
    'Let’s connect about a product, a Flutter project, or a professional opportunity. Based in Cairo. Open to conversations worldwide.',
    'يسعدني التواصل لمناقشة منتج أو مشروع Flutter أو فرصة مهنية. مقيم في القاهرة وأرحب بالتواصل من مختلف الأسواق.',
  );
  static const linkedin = Bilingual('Connect on LinkedIn', 'تواصل عبر لينكدإن');
  static const github = Bilingual('GitHub', 'GitHub');
  static const facebook = Bilingual('Facebook', 'فيسبوك');
  static const linkFailed = Bilingual(
    'The link could not be opened. Please try again.',
    'تعذر فتح الرابط. يرجى المحاولة مرة أخرى.',
  );
  static const imageFailed = Bilingual(
    'Project image unavailable',
    'صورة المشروع غير متاحة',
  );
  static const footer = Bilingual(
    'Built with Flutter. Made with care.',
    'بُني باستخدام Flutter، بعناية بالتفاصيل.',
  );
  static const projectNote = Bilingual(
    'Product features describe the application; my contribution is part of a wider team effort.',
    'تصف المزايا وظائف التطبيق، ومساهمتي جزء من عمل فريق المنتج.',
  );
  static const menu = Bilingual('Navigation', 'التنقل');
  static const firstName = Bilingual('Abdelrahman', 'عبدالرحمن');
  static const lastName = Bilingual('Amr', 'عمرو');
  static const allWork = Bilingual('All projects', 'جميع المشاريع');
  static const browseAll = Bilingual(
    'Browse all 19 projects',
    'تصفح جميع المشاريع الـ ١٩',
  );
  static const search = Bilingual(
    'Search projects or technologies',
    'ابحث عن مشروع أو تقنية',
  );
  static const noResults = Bilingual(
    'No matching projects. Try another search.',
    'لا توجد مشاريع مطابقة. جرّب بحثًا آخر.',
  );
  static const previous = Bilingual('Previous image', 'الصورة السابقة');
  static const next = Bilingual('Next image', 'الصورة التالية');
  static const enlarge = Bilingual('Open larger image', 'عرض الصورة بحجم أكبر');
  static const play = Bilingual('Play video', 'تشغيل الفيديو');
  static const pause = Bilingual('Pause', 'إيقاف مؤقت');
  static const resume = Bilingual('Resume slideshow', 'متابعة العرض');
  static const pauseSlides = Bilingual('Pause slideshow', 'إيقاف العرض مؤقتًا');
  static const videoFailed = Bilingual(
    'Video unavailable. Explore the project link instead.',
    'تعذر تشغيل الفيديو. يمكنك استعراض رابط المشروع.',
  );
  static const overview = Bilingual('Project overview', 'نظرة على المشروع');
  static const closeArchive = Bilingual(
    'Close all projects',
    'إغلاق جميع المشاريع',
  );
}

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.contribution,
    required this.features,
    required this.images,
    required this.tags,
    required this.url,
    this.code = false,
  });
  final String id;
  final String name;
  final Bilingual category;
  final Bilingual description;
  final Bilingual contribution;
  final List<Bilingual> features;
  final List<String> images;
  final List<String> tags;
  final String url;
  final bool code;
}

final projects = [
  Project(
    id: 'addustour',
    name: 'ADDUSTOUR',
    category: Bilingual('NEWS & MEDIA', 'أخبار وإعلام'),
    description: Bilingual(
      'A mobile news application bringing updates, search, and notifications into one reading experience.',
      'تطبيق أخبار يجمع التحديثات والبحث والإشعارات في تجربة قراءة واحدة.',
    ),
    contribution: Bilingual(
      'Contributed to Flutter application development during my freelance work with ProsysJo.',
      'ساهمت في تطوير التطبيق باستخدام Flutter خلال عملي المستقل مع ProsysJo.',
    ),
    features: [
      Bilingual('News updates and notifications', 'تحديثات الأخبار والإشعارات'),
      Bilingual(
        'Authentication and advanced search',
        'تسجيل الدخول والبحث المتقدم',
      ),
      Bilingual(
        'SQL storage and WebView integration',
        'التخزين باستخدام SQL ودمج WebView',
      ),
    ],
    images: projectMedia['addustour']!,
    tags: ['Flutter', 'News', 'Notifications'],
    url: 'https://apps.apple.com/us/app/addustour/id6444052571',
  ),
  Project(
    id: 'thamin',
    name: 'Thamin',
    category: Bilingual('PRICING & MARKETPLACES', 'تسعير وأسواق إلكترونية'),
    description: Bilingual(
      'An application for AI-driven pricing of pre-owned goods, PDF reports, and marketplace integration.',
      'تطبيق لتسعير السلع المستعملة بالاعتماد على الذكاء الاصطناعي، مع تقارير PDF والتكامل مع الأسواق الإلكترونية.',
    ),
    contribution: Bilingual(
      'Contributed to Flutter application development at Code-X.',
      'ساهمت في تطوير التطبيق باستخدام Flutter لدى Code-X.',
    ),
    features: [
      Bilingual(
        'Pre-owned goods pricing workflow',
        'تجربة تسعير السلع المستعملة',
      ),
      Bilingual('PDF reporting', 'تقارير PDF'),
      Bilingual('Marketplace integration', 'التكامل مع الأسواق الإلكترونية'),
    ],
    images: projectMedia['thamin']!,
    tags: ['Flutter', 'PDF', 'Marketplace'],
    url: 'https://apps.apple.com/jo/app/thmmn-%D8%AB%D9%85%D9%86/id6758052199',
  ),
  Project(
    id: 'sadad',
    name: 'SADAD',
    category: Bilingual('FINANCIAL SERVICES', 'خدمات مالية'),
    description: Bilingual(
      'A financial-services application supporting gift cards, bill payments, and digital receipts.',
      'تطبيق خدمات مالية يدعم بطاقات الهدايا وسداد الفواتير والإيصالات الرقمية.',
    ),
    contribution: Bilingual(
      'Contributed to Flutter application development during my freelance work with ProsysJo.',
      'ساهمت في تطوير التطبيق باستخدام Flutter خلال عملي المستقل مع ProsysJo.',
    ),
    features: [
      Bilingual('Gift-card workflows', 'عمليات بطاقات الهدايا'),
      Bilingual('Bill payments', 'سداد الفواتير'),
      Bilingual('Digital receipts', 'إيصالات رقمية'),
    ],
    images: projectMedia['sadad']!,
    tags: ['Flutter', 'Payments', 'Mobile'],
    url: 'https://play.google.com/store/apps/details?id=com.sadad.sadad',
  ),
  Project(
    id: 'pack-and-go',
    name: 'Pack and Go',
    category: Bilingual('REAL ESTATE', 'عقارات'),
    description: Bilingual(
      'A real-estate platform connecting property seekers and agents, with separate user and owner Flutter applications.',
      'منصة عقارية تربط الباحثين عن العقارات بالوكلاء، مع تطبيقَي Flutter منفصلين للمستخدم والمالك.',
    ),
    contribution: Bilingual(
      'Worked on Pack and Go at LEAPTECH. The public repository contains separate owner/ and user/ applications.',
      'عملت على Pack and Go لدى LEAPTECH. يحتوي المستودع العام على تطبيقين منفصلين للمالك والمستخدم.',
    ),
    features: [
      Bilingual(
        'Property discovery and management',
        'استكشاف العقارات وإدارتها',
      ),
      Bilingual(
        'Communication between seekers and agents',
        'التواصل بين الباحثين عن العقارات والوكلاء',
      ),
      Bilingual(
        'BLoC, Dio, GetIt, maps, and local-storage dependencies',
        'اعتماديات BLoC وDio وGetIt والخرائط والتخزين المحلي',
      ),
    ],
    images: projectMedia['pack-and-go']!,
    tags: ['Flutter', 'BLoC', 'Real estate'],
    url: 'https://github.com/abdo6400/real_state_app_using_flutter',
    code: true,
  ),
];

class ExperienceEntry {
  const ExperienceEntry(this.company, this.role, this.period, this.summary);
  final String company;
  final Bilingual role;
  final Bilingual period;
  final Bilingual summary;
}

const experiences = [
  ExperienceEntry(
    'digitalH',
    Bilingual('Senior Flutter Developer', 'مطور Flutter أول'),
    Bilingual('AUG 2026 — PRESENT', 'أغسطس ٢٠٢٦ — الآن'),
    Bilingual(
      'Mobile product development. Full-time, remote from Cairo.',
      'تطوير منتجات الموبايل، بدوام كامل وعن بُعد من القاهرة.',
    ),
  ),
  ExperienceEntry(
    'Code-X',
    Bilingual('Flutter Developer', 'مطور Flutter'),
    Bilingual('JAN 2025 — MAR 2026', 'يناير ٢٠٢٥ — مارس ٢٠٢٦'),
    Bilingual(
      'TrendUp, Thamin, Package, and Khair Al-Madina. API integration, feature delivery, and post-launch maintenance.',
      'تطبيقات TrendUp وThamin وPackage وخير المدينة، وربط الخدمات وإضافة المزايا والصيانة بعد الإطلاق.',
    ),
  ),
  ExperienceEntry(
    'LEAPTECH',
    Bilingual('Flutter Developer', 'مطور Flutter'),
    Bilingual('2023 — 2024', '٢٠٢٣ — ٢٠٢٤'),
    Bilingual(
      'Pack and Go, Car Washing App, and Najam Al Kora. REST APIs, BLoC, and collaboration with backend and QA teams.',
      'تطبيقات Pack and Go وغسيل السيارات ونجم الكرة، مع REST APIs وBLoC والتعاون مع الباك إند واختبار الجودة.',
    ),
  ),
  ExperienceEntry(
    'ProsysJo',
    Bilingual('Freelance Flutter Developer', 'مطور Flutter مستقل'),
    Bilingual('2022 — 2024', '٢٠٢٢ — ٢٠٢٤'),
    Bilingual(
      'ADDUSTOUR, ALBASHEQ, Golden Mark, and SADAD. Mobile application development and maintenance.',
      'تطبيقات ADDUSTOUR وALBASHEQ وGolden Mark وSADAD، وتطوير تطبيقات الموبايل وصيانتها.',
    ),
  ),
];
