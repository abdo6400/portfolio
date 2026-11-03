import 'portfolio_content.dart';

abstract final class StudioCopy {
  static const showcaseHint = Bilingual(
    'Swipe or use arrow keys to browse projects. Press space to pause or resume.',
    'اسحب أو استخدم مفاتيح الأسهم لتصفح المشاريع.',
  );
  static const nextProject = Bilingual('Next project', 'المشروع التالي');
  static const previousProject = Bilingual(
    'Previous project',
    'المشروع السابق',
  );
  static const home = Bilingual('Home', 'الرئيسية');
  static const skills = Bilingual('Skills', 'المهارات');
  static const projects = Bilingual('Projects', 'المشاريع');
  static const services = Bilingual('How I can help', 'كيف أساعدك');
  static const available = Bilingual(
    'Open to meaningful collaborations',
    'أرحب بالتعاون في مشاريع مميزة',
  );
  static const hero = Bilingual(
    'Building Beautiful Digital Experiences with Flutter.',
    'أطوّر تجارب رقمية متقنة باستخدام Flutter.',
  );
  static const heroLead = Bilingual(
    'Building Beautiful\nDigital Experiences',
    'أطوّر تجارب رقمية متقنة',
  );
  static const heroAccent = Bilingual('with Flutter.', 'باستخدام Flutter.');
  static const intro = Bilingual(
    'I’m Abdelrahman, a Senior Flutter Developer in Cairo. I turn product ideas into polished, maintainable applications for mobile and beyond.',
    'أنا عبدالرحمن، مطوّر Flutter أول مقيم في القاهرة. أحوّل أفكار المنتجات إلى تطبيقات متقنة وسهلة الصيانة للهواتف والمنصات الأخرى.',
  );
  static const contactMe = Bilingual('Contact me', 'تواصل معي');
  static const scroll = Bilingual('Discover the details', 'اكتشف التفاصيل');
  static const aboutTitle = Bilingual(
    'Thoughtful code.\nConsidered experiences.',
    'شيفرة مدروسة.\nوتجارب صُممت بعناية.',
  );
  static const aboutBody = Bilingual(
    'I work where product design meets engineering. From news and financial services to marketplaces, my focus is clear architecture, dependable state management, and interfaces people enjoy using. Today, I build mobile products at digitalH.',
    'أجمع بين تصميم المنتجات وهندسة البرمجيات لتطوير تطبيقات في مجالات الأخبار والخدمات المالية والتجارة الإلكترونية. أحرص على بنية واضحة، وإدارة موثوقة لحالة التطبيق، وواجهات سهلة الاستخدام. أعمل حاليًا على تطوير تطبيقات الهواتف لدى digitalH.',
  );
  static const skillsTitle = Bilingual(
    'A focused stack.\nA broader perspective.',
    'أدوات مختارة.\nورؤية أوسع.',
  );
  static const skillsBody = Bilingual(
    'The tools I use to connect thoughtful interfaces with dependable systems.',
    'أستخدم هذه الأدوات لبناء واجهات سهلة الاستخدام وربطها بأنظمة موثوقة.',
  );
  static const projectsTitle = Bilingual(
    'Real products.\nWork worth exploring.',
    'منتجات حقيقية.\nوأعمال تستحق الاستكشاف.',
  );
  static const all = Bilingual('Featured', 'مشاريع مختارة');
  static const mobile = Bilingual('Mobile apps', 'تطبيقات الهواتف');
  static const backend = Bilingual('Backend', 'الخدمات الخلفية');
  static const experiments = Bilingual('Experiments', 'تجارب');
  static const journey = Bilingual('The journey so far.', 'رحلتي حتى الآن.');
  static const servicesTitle = Bilingual(
    'From first screen\nto the next release.',
    'من أول شاشة\nإلى الإصدار القادم.',
  );
  static const contactTitle = Bilingual(
    'Let’s make\nsomething matter.',
    'لنبنِ معًا\nمنتجًا يصنع فرقًا.',
  );
  static const light = Bilingual(
    'Switch to light theme',
    'تفعيل المظهر الفاتح',
  );
  static const dark = Bilingual('Switch to dark theme', 'تفعيل المظهر الداكن');
  static const nameLabel = Bilingual('Your name', 'اسمك');
  static const email = Bilingual('Your email', 'بريدك الإلكتروني');
  static const emailLink = Bilingual('Email', 'البريد الإلكتروني');
  static const message = Bilingual(
    'Tell me about your idea',
    'أخبرني عن فكرتك',
  );
  static const compose = Bilingual(
    'Copy message & open LinkedIn',
    'انسخ الرسالة وافتح لينكدإن',
  );
  static const formNote = Bilingual(
    'This form prepares a message for LinkedIn. Nothing is sent automatically.',
    'يجهّز هذا النموذج رسالة يمكنك إرسالها عبر لينكدإن. لن تُرسل الرسالة تلقائيًا.',
  );
  static const requiredName = Bilingual(
    'Please enter your name.',
    'يرجى إدخال اسمك.',
  );
  static const invalidEmail = Bilingual(
    'Enter a valid email address.',
    'يرجى إدخال بريد إلكتروني صحيح.',
  );
  static const shortMessage = Bilingual(
    'Please write at least 20 characters.',
    'يرجى كتابة ٢٠ حرفًا على الأقل.',
  );
  static const prepared = Bilingual(
    'Message copied. Paste it into LinkedIn to send it.',
    'تم نسخ الرسالة. الصقها في لينكدإن لإرسالها.',
  );
  static const linkUnavailable = Bilingual(
    'Message copied, but LinkedIn could not open. Use the profile link to continue.',
    'تم نسخ الرسالة، لكن تعذر فتح لينكدإن. استخدم رابط الملف الشخصي للمتابعة.',
  );
  static const copyFailed = Bilingual(
    'Could not copy the message. Please use the LinkedIn link.',
    'تعذر نسخ الرسالة. يرجى استخدام رابط لينكدإن.',
  );
  static const preparing = Bilingual(
    'Preparing your message…',
    'جارٍ تجهيز الرسالة…',
  );
  static const profile = Bilingual(
    'Portrait of Abdelrahman Amr',
    'صورة عبدالرحمن عمرو',
  );
  static const selected = Bilingual('Selected application', 'تطبيق مختار');
  static const buildLabel = Bilingual(
    'Cross-platform. Product-minded.',
    'متعدد المنصات · يضع المنتج أولًا',
  );
  static const publicWork = Bilingual(
    'Projects in the archive',
    'مشروعًا في الأرشيف',
  );
  static const languages = Bilingual('Portfolio languages', 'لغتا الموقع');
  static const education = Bilingual('Education', 'التعليم');
  static const location = Bilingual(
    'Cairo, Egypt · Working worldwide',
    'القاهرة، مصر · أتعاون مع مختلف الأسواق',
  );
}

class SkillGroup {
  const SkillGroup(this.title, this.items);
  final Bilingual title;
  final List<String> items;
}

const skillGroups = [
  SkillGroup(Bilingual('Mobile development', 'تطوير تطبيقات الهواتف'), [
    'Flutter',
    'Dart',
    'Responsive UI',
  ]),
  SkillGroup(Bilingual('Backend integration', 'التكامل مع الخدمات الخلفية'), [
    'REST APIs',
    'Firebase',
    'Dio',
    '.NET / ASP.NET Core',
  ]),
  SkillGroup(Bilingual('Architecture & state', 'البنية وإدارة الحالة'), [
    'Clean Architecture',
    'BLoC',
    'Provider',
    'GetIt',
  ]),
  SkillGroup(Bilingual('Tools & delivery', 'الأدوات والتسليم'), [
    'Git',
    'GitHub',
    'CI/CD',
    'App maintenance',
  ]),
];

class ServiceItem {
  const ServiceItem(this.title, this.body);
  final Bilingual title, body;
}

const serviceItems = [
  ServiceItem(
    Bilingual('Flutter development', 'تطوير Flutter'),
    Bilingual(
      'Cross-platform mobile applications built around your product and its users.',
      'تطبيقات متعددة المنصات تُصمّم لتلبية احتياجات منتجك ومستخدميه.',
    ),
  ),
  ServiceItem(
    Bilingual('Interfaces with intent', 'واجهات مدروسة'),
    Bilingual(
      'Responsive UI implementation with care for interaction, accessibility, and detail.',
      'تطوير واجهات متجاوبة مع الاهتمام بسهولة الاستخدام وإمكانية الوصول والتفاصيل.',
    ),
  ),
  ServiceItem(
    Bilingual('Connected products', 'منتجات متكاملة'),
    Bilingual(
      'REST API and Firebase integration that connects the interface to your services.',
      'ربط واجهات التطبيقات بخدماتك باستخدام REST APIs وFirebase.',
    ),
  ),
  ServiceItem(
    Bilingual('Performance & maintenance', 'الأداء والصيانة'),
    Bilingual(
      'Refining existing applications, resolving issues, and supporting their next release.',
      'تحسين التطبيقات الحالية وحل المشكلات ودعم إصدارها القادم.',
    ),
  ),
];

abstract final class ContactLinks {
  static const emailAddress = String.fromEnvironment('PORTFOLIO_EMAIL');
  static const linkedin =
      'https://www.linkedin.com/in/abdelrahman-amr-729400204/';
  static const github = 'https://github.com/abdo6400';
  static const facebook = 'https://www.facebook.com/abdo.amr.1048';
}
