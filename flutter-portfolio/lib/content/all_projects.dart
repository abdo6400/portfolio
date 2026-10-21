import 'portfolio_content.dart';
import 'project_media.dart';

final allProjects = <Project>[
  projects.firstWhere((p) => p.id == "addustour"),
  Project(
    id: "albasheq",
    name: "ALBASHEQ",
    category: Bilingual("Financial", "خدمات مالية"),
    description: Bilingual(
      "Premium digital card purchasing platform with secure transaction handling and printing.",
      "تطبيق لشراء البطاقات الرقمية، مع إدارة المعاملات وطباعة الإيصالات.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Dio.",
      "تطوير باستخدام Flutter, Bloc, Dio.",
    ),
    features: [
      Bilingual(
        "Secure wallet management and transactions",
        "شراء البطاقات الرقمية",
      ),
      Bilingual(
        "Bluetooth thermal printer integration for receipts",
        "طباعة الإيصالات عبر Bluetooth",
      ),
    ],
    images: projectMedia["albasheq"]!,
    tags: ["Flutter", "Bloc", "Dio", "Bluetooth SDK"],
    url: "https://apps.apple.com/jo/app/albasheq/id6462672573",
    code: false,
  ),
  Project(
    id: "golden-mark",
    name: "Golden Mark",
    category: Bilingual("Financial", "خدمات مالية"),
    description: Bilingual(
      "Enterprise-grade digital asset management and purchasing system for financial services.",
      "تطبيق للخدمات المالية وشراء البطاقات الرقمية وإدارة معاملاتها.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Dio.",
      "تطوير باستخدام Flutter, Bloc, Dio.",
    ),
    features: [
      Bilingual("Integrated provider API gateway", "شراء البطاقات الرقمية"),
      Bilingual(
        "Batch processing for card issuance",
        "تقارير المعاملات والطباعة",
      ),
    ],
    images: projectMedia["golden-mark"]!,
    tags: ["Flutter", "Bloc", "Dio", "Secure Storage"],
    url: "https://play.google.com/store/apps/details?id=com.goldenmark.golden_mark",
    code: false,
  ),
  projects.firstWhere((p) => p.id == "sadad"),
  projects.firstWhere((p) => p.id == "pack-and-go"),
  Project(
    id: "trendup",
    name: "TrendUp",
    category: Bilingual("E-commerce", "تجارة إلكترونية"),
    description: Bilingual(
      "A social marketplace for product reselling with integrated profit tracking.",
      "منصة للتجارة الإلكترونية وإعادة بيع المنتجات، مع متابعة الأرباح.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, GoRouter.",
      "تطوير باستخدام Flutter, Bloc, GoRouter.",
    ),
    features: [
      Bilingual("Inventory procurement system", "كتالوج المنتجات"),
      Bilingual(
        "Integrated profit and margin calculator",
        "متابعة الأرباح وإعادة البيع",
      ),
    ],
    images: projectMedia["trendup"]!,
    tags: ["Flutter", "Bloc", "GoRouter", "Firebase Storage"],
    url: "https://play.google.com/store/apps/details?id=com.trendup.trendup",
    code: false,
  ),
  Project(
    id: "package",
    name: "Package",
    category: Bilingual("Services", "خدمات"),
    description: Bilingual(
      "A digital directory for technical and digital services, with geographic filtering.",
      "دليل للخدمات التقنية والرقمية، مع تصنيف الخدمات والبحث حسب الموقع.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Google Maps SDK.",
      "تطوير باستخدام Flutter, Bloc, Google Maps SDK.",
    ),
    features: [
      Bilingual(
        "Geographic scope filtering (Radius-based)",
        "تصنيف مقدمي الخدمات",
      ),
      Bilingual(
        "Verified technician directory with ratings",
        "البحث حسب الموقع",
      ),
    ],
    images: projectMedia["package"]!,
    tags: ["Flutter", "Bloc", "Google Maps SDK", "Firebase Firestore"],
    url:
        "https://apps.apple.com/jo/app/package-%D8%A8%D9%83%D8%AC/id1523239962",
    code: false,
  ),
  projects.firstWhere((p) => p.id == "thamin"),
  Project(
    id: "khair-al-madina",
    name: "Khair Al-Madina",
    category: Bilingual("Charity", "عمل خيري"),
    description: Bilingual(
      "Humanitarian logistics platform coordinating water donations for mosques.",
      "منصة لتنسيق التبرع بالمياه للمساجد ومتابعة التوصيل.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Google Maps.",
      "تطوير باستخدام Flutter, Bloc, Google Maps.",
    ),
    features: [
      Bilingual(
        "Real-time donation tracking and status",
        "التبرع بالمياه للمساجد",
      ),
      Bilingual(
        "Supply chain coordination with delivery firms",
        "متابعة الطلبات والتوصيل",
      ),
    ],
    images: projectMedia["khair-al-madina"]!,
    tags: ["Flutter", "Bloc", "Google Maps", "Firebase"],
    url: "https://apps.apple.com/jo/app/%D8%AE%D9%8A%D8%B1-%D8%A7%D9%84%D9%85%D8%AF%D9%8I%D9%86%D8%A9/id6742254303",
    code: false,
  ),
  Project(
    id: "jamala",
    name: "Jamala",
    category: Bilingual("E-commerce", "تجارة إلكترونية"),
    description: Bilingual(
      "Comprehensive e-commerce platform for digital shopping experiences.",
      "تطبيق للتسوق الإلكتروني وتصفح المنتجات وإدارة الطلبات.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Firebase.",
      "تطوير باستخدام Flutter, Bloc, Firebase.",
    ),
    features: [
      Bilingual("Multi-category product catalog", "كتالوج المنتجات"),
      Bilingual(
        "Secure checkout and payment gateway",
        "الشراء ومتابعة الطلبات",
      ),
    ],
    images: projectMedia["jamala"]!,
    tags: ["Flutter", "Bloc", "Firebase", "REST API"],
    url: "https://github.com/abdo6400/JamalaShoppingApp_using_flutter",
    code: true,
  ),
  Project(
    id: "leap-tech",
    name: "Leap Tech",
    category: Bilingual("Financial", "خدمات مالية"),
    description: Bilingual(
      "Innovative enterprise solutions for financial asset management.",
      "تطبيق لإدارة الأصول والخدمات المالية للمؤسسات.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Provider, Rest API.",
      "تطوير باستخدام Flutter, Provider, Rest API.",
    ),
    features: [
      Bilingual("Real-time asset tracking", "إدارة الأصول"),
      Bilingual("Enterprise-grade security", "التقارير المالية"),
    ],
    images: projectMedia["leap-tech"]!,
    tags: ["Flutter", "Provider", "Rest API", "Secure Storage"],
    url: "",
    code: false,
  ),
  Project(
    id: "nejam-al-kora",
    name: "Nejam Al Kora",
    category: Bilingual("News Application", "أخبار وإعلام"),
    description: Bilingual(
      "Real-time sports news and media application for football enthusiasts.",
      "تطبيق للأخبار الرياضية ومحتوى كرة القدم.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Firebase Cloud Messaging.",
      "تطوير باستخدام Flutter, Bloc, Firebase Cloud Messaging.",
    ),
    features: [
      Bilingual("Live score updates", "الأخبار الرياضية"),
      Bilingual(
        "Breaking sports news notifications",
        "الإشعارات ومحتوى المباريات",
      ),
    ],
    images: projectMedia["nejam-al-kora"]!,
    tags: ["Flutter", "Bloc", "Firebase Cloud Messaging", "Video Player"],
    url: "",
    code: false,
  ),
  Project(
    id: "car-washing",
    name: "Car Washing",
    category: Bilingual("Services", "خدمات"),
    description: Bilingual(
      "On-demand car maintenance and professional washing services.",
      "تطبيق لحجز خدمات غسيل السيارات والعناية بها حسب الموقع.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Google Maps SDK.",
      "تطوير باستخدام Flutter, Bloc, Google Maps SDK.",
    ),
    features: [
      Bilingual("Service booking and scheduling", "حجز الخدمات"),
      Bilingual("Location-based provider matching", "تحديد الموقع والتقييمات"),
    ],
    images: projectMedia["car-washing"]!,
    tags: ["Flutter", "Bloc", "Google Maps SDK", "Stripe Integration"],
    url: "https://github.com/abdo6400/washing_app_using_flutter",
    code: true,
  ),
  Project(
    id: "ama-e-commerce",
    name: "AMA E-Commerce",
    category: Bilingual("E-commerce", "تجارة إلكترونية"),
    description: Bilingual(
      "Full-stack e-commerce platform with a User App and a Delivery Man App for seamless shopping and logistics.",
      "منصة تجارة إلكترونية تضم تطبيقًا للمستخدم وآخر لمندوب التوصيل.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Bloc, Clean Architecture.",
      "تطوير باستخدام Flutter, Bloc, Clean Architecture.",
    ),
    features: [
      Bilingual(
        "Dual-app architecture: User App + Delivery Man App",
        "تطبيق المستخدم ومندوب التوصيل",
      ),
      Bilingual(
        "Advanced product search with smart filters",
        "متابعة الطلبات والتوصيل",
      ),
    ],
    images: projectMedia["ama-e-commerce"]!,
    tags: ["Flutter", "Bloc", "Clean Architecture", "REST API"],
    url: "https://github.com/abdo6400/AMA-E-COMMERCE",
    code: true,
  ),
  Project(
    id: "arkanoid-game",
    name: "Arkanoid Game",
    category: Bilingual("Game", "ألعاب"),
    description: Bilingual(
      "A Java-based classic arcade Arkanoid game with power-ups, enemies, laser cannons, and multi-level gameplay.",
      "لعبة Arkanoid كلاسيكية باستخدام Java، مع مراحل متعددة وأعداء وقدرات إضافية.",
    ),
    contribution: Bilingual(
      "Implementation with Java, OOP, Data Structures.",
      "تطوير باستخدام Java, OOP, Data Structures.",
    ),
    features: [
      Bilingual(
        "Classic Arkanoid paddle-and-ball gameplay",
        "لعبة المضرب والكرة",
      ),
      Bilingual(
        "Power-up system: laser cannon, multi-ball, sticky ball, size expansion",
        "مراحل وقدرات إضافية",
      ),
    ],
    images: projectMedia["arkanoid-game"]!,
    tags: ["Java", "OOP", "Data Structures", "Design Patterns"],
    url: "https://github.com/abdo6400/ARkANOID_GAME_using_java",
    code: true,
  ),
  Project(
    id: "retail-pc-stores",
    name: "Retail PC Stores",
    category: Bilingual("Services", "خدمات"),
    description: Bilingual(
      "Full-featured POS system for retail stores with offline support, barcode scanning, USB printing, and multi-language Arabic/English UI.",
      "نظام نقاط بيع يدعم العمل دون اتصال وقارئ الباركود وطباعة الإيصالات والعربية والإنجليزية.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, BLoC / HydratedBloc, Clean Architecture.",
      "تطوير باستخدام Flutter, BLoC / HydratedBloc, Clean Architecture.",
    ),
    features: [
      Bilingual(
        "Full offline-first operation with SQLite local database",
        "نقاط بيع وتخزين محلي",
      ),
      Bilingual(
        "USB barcode scanner integration for fast product lookup",
        "باركود وطباعة الإيصالات",
      ),
    ],
    images: projectMedia["retail-pc-stores"]!,
    tags: ["Flutter", "BLoC / HydratedBloc", "Clean Architecture", "Dio"],
    url: "https://apps.apple.com/jo/app/retail-pc-stores/id6753711418",
    code: false,
  ),
  Project(
    id: "iot-parking-system",
    name: "IoT Parking System",
    category: Bilingual("IoT", "إنترنت الأشياء"),
    description: Bilingual(
      "IoT-based smart parking management system that tracks real-time parking space availability using connected sensors and WebSockets.",
      "نظام لإدارة مواقف السيارات ومتابعة الأماكن المتاحة باستخدام الحساسات وWebSockets.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, WebSocket (web_socket_channel), IoT Integration.",
      "تطوير باستخدام Flutter, WebSocket (web_socket_channel), IoT Integration.",
    ),
    features: [
      Bilingual(
        "Real-time parking space availability via IoT sensors",
        "حالة أماكن الانتظار لحظيًا",
      ),
      Bilingual(
        "WebSocket-based live data streaming from hardware",
        "التكامل مع الحساسات وWebSockets",
      ),
    ],
    images: projectMedia["iot-parking-system"]!,
    tags: [
      "Flutter",
      "WebSocket (web_socket_channel)",
      "IoT Integration",
      "Network Info Plus",
    ],
    url: "https://github.com/abdo6400/parking_system_using_flutter",
    code: true,
  ),
  Project(
    id: "speech-emotion-recognition",
    name: "Speech Emotion Recognition",
    category: Bilingual("AI", "ذكاء اصطناعي"),
    description: Bilingual(
      "Real-time speech emotion recognition system using deep learning (LSTM) with a Flutter mobile app and web interface.",
      "نظام للتعرف على المشاعر من الصوت، مع تطبيق Flutter وواجهة ويب.",
    ),
    contribution: Bilingual(
      "Implementation with Flutter, Python (FastAPI/Flask), TensorFlow / Keras.",
      "تطوير باستخدام Flutter, Python (FastAPI/Flask), TensorFlow / Keras.",
    ),
    features: [
      Bilingual(
        "Real-time emotion identification from audio signals",
        "تحليل الصوت والتعرف على المشاعر",
      ),
      Bilingual(
        "CUDA-enabled LSTM deep learning architecture",
        "واجهة موبايل وويب",
      ),
    ],
    images: projectMedia["speech-emotion-recognition"]!,
    tags: [
      "Flutter",
      "Python (FastAPI/Flask)",
      "TensorFlow / Keras",
      "LSTM Architecture",
    ],
    url: "https://github.com/abdo6400/speech_emotion_app_using_flutter",
    code: true,
  ),
  Project(
    id: "e-commerce-backend-api",
    name: "E-commerce Backend API",
    category: Bilingual("E-commerce", "تجارة إلكترونية"),
    description: Bilingual(
      "Robust .NET 8.0 enterprise-grade backend for scalable e-commerce platforms with Stripe and SignalR.",
      "خدمات خلفية للتجارة الإلكترونية باستخدام .NET وASP.NET Core، مع Stripe وSignalR.",
    ),
    contribution: Bilingual(
      "Implementation with .NET 8.0, ASP.NET Core, EF Core.",
      "تطوير باستخدام .NET 8.0, ASP.NET Core, EF Core.",
    ),
    features: [
      Bilingual(
        "Modern .NET 8.0 & ASP.NET Core implementation",
        "خدمات التجارة الإلكترونية",
      ),
      Bilingual(
        "Stripe.net integration for secure payment processing",
        "المدفوعات والتواصل اللحظي",
      ),
    ],
    images: projectMedia["e-commerce-backend-api"]!,
    tags: [".NET 8.0", "ASP.NET Core", "EF Core", "SQL Server"],
    url: "https://github.com/abdo6400/ecommerce_backend",
    code: true,
  ),
];
