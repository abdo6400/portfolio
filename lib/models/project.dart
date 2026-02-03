class Project {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageDesc;
  final List<String> techStack;
  final String? caseStudyUrl;
  final String? liveUrl;
  final DateTime createdAt;

  Project({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageDesc,
    required this.techStack,
    this.caseStudyUrl,
    this.liveUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'description': description,
    'imageDesc': imageDesc,
    'techStack': techStack,
    'caseStudyUrl': caseStudyUrl,
    'liveUrl': liveUrl,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'] as String,
    title: json['title'] as String,
    category: json['category'] as String,
    description: json['description'] as String,
    imageDesc: json['imageDesc'] as String,
    techStack: List<String>.from(json['techStack'] as List),
    caseStudyUrl: json['caseStudyUrl'] as String?,
    liveUrl: json['liveUrl'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Project copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    String? imageDesc,
    List<String>? techStack,
    String? caseStudyUrl,
    String? liveUrl,
    DateTime? createdAt,
  }) => Project(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    description: description ?? this.description,
    imageDesc: imageDesc ?? this.imageDesc,
    techStack: techStack ?? this.techStack,
    caseStudyUrl: caseStudyUrl ?? this.caseStudyUrl,
    liveUrl: liveUrl ?? this.liveUrl,
    createdAt: createdAt ?? this.createdAt,
  );
}
