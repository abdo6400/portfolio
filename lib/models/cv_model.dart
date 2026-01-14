class CV {
  final String name;
  final ContactInformation contactInformation;
  final String summary;
  final List<WorkExperience> workExperience;
  final Skills skills;
  final Education education;
  final List<Project> projects;
  final AdditionalInformation additionalInformation;

  CV({
    required this.name,
    required this.contactInformation,
    required this.summary,
    required this.workExperience,
    required this.skills,
    required this.education,
    required this.projects,
    required this.additionalInformation,
  });

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      name: json['name'],
      contactInformation:
          ContactInformation.fromJson(json['contact_information']),
      summary: json['summary'],
      workExperience: (json['work_experience'] as List)
          .map((e) => WorkExperience.fromJson(e))
          .toList(),
      skills: Skills.fromJson(json['skills']),
      education: Education.fromJson(json['education']),
      projects:
          (json['projects'] as List).map((e) => Project.fromJson(e)).toList(),
      additionalInformation:
          AdditionalInformation.fromJson(json['additional_information']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contact_information': contactInformation.toJson(),
      'summary': summary,
      'work_experience': workExperience.map((e) => e.toJson()).toList(),
      'skills': skills.toJson(),
      'education': education.toJson(),
      'projects': projects.map((e) => e.toJson()).toList(),
      'additional_information': additionalInformation.toJson(),
    };
  }
}

class ContactInformation {
  final String email;
  final String phone;
  final String location;

  ContactInformation({
    required this.email,
    required this.phone,
    required this.location,
  });

  factory ContactInformation.fromJson(Map<String, dynamic> json) {
    return ContactInformation(
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'location': location,
    };
  }
}

class WorkExperience {
  final String company;
  final String position;
  final String type;
  final List<String> responsibilities;
  final String duration;

  WorkExperience({
    required this.company,
    required this.position,
    required this.type,
    required this.responsibilities,
    required this.duration,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      company: json['company'],
      position: json['position'],
      type: json['type'],
      responsibilities: List<String>.from(json['responsibilities']),
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      'type': type,
      'responsibilities': responsibilities,
      'duration': duration,
    };
  }
}

class Skills {
  final List<String> languages;
  final List<String> frameworks;
  final List<String> developmentPractices;
  final List<String> toolsAndLibraries;

  Skills({
    required this.languages,
    required this.frameworks,
    required this.developmentPractices,
    required this.toolsAndLibraries,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      languages: List<String>.from(json['languages']),
      frameworks: List<String>.from(json['frameworks']),
      developmentPractices: List<String>.from(json['development_practices']),
      toolsAndLibraries: List<String>.from(json['tools_and_libraries']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languages': languages,
      'frameworks': frameworks,
      'development_practices': developmentPractices,
      'tools_and_libraries': toolsAndLibraries,
    };
  }
}

class Education {
  final String institution;
  final String degree;
  final String duration;

  Education({
    required this.institution,
    required this.degree,
    required this.duration,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'],
      degree: json['degree'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'duration': duration,
    };
  }
}

class Project {
  final String name;
  final String? description;
  final List<String> skillsUsed;
  final String? githubLink;
  final String? appleStoreLink;
  final String? googlePlayLink;
  final String? image;

  Project({
    required this.name,
    this.description,
    required this.skillsUsed,
    this.githubLink,
    this.appleStoreLink,
    this.googlePlayLink,
    this.image,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
      skillsUsed: List<String>.from(json['skills_used']),
      githubLink: json['github_link'],
      appleStoreLink: json['apple_store_link'],
      googlePlayLink: json['google_play_link'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'skills_used': skillsUsed,
      'github_link': githubLink,
      'apple_store_link': appleStoreLink,
      'google_play_link': googlePlayLink,
      'image': image,
    };
  }
}

class AdditionalInformation {
  final List<String> languages;
  final String awardsActivities;
  final SocialLinks socialLinks;

  AdditionalInformation({
    required this.languages,
    required this.awardsActivities,
    required this.socialLinks,
  });

  factory AdditionalInformation.fromJson(Map<String, dynamic> json) {
    return AdditionalInformation(
      languages: List<String>.from(json['languages']),
      awardsActivities: json['awards_activities'],
      socialLinks: SocialLinks.fromJson(json['social_links']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languages': languages,
      'awards_activities': awardsActivities,
      'social_links': socialLinks.toJson(),
    };
  }
}

class SocialLinks {
  final String github;
  final String linkedin;

  final String cv;

  SocialLinks({
    required this.github,
    required this.linkedin,
    required this.cv,
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) {
    return SocialLinks(
      github: json['github'],
      linkedin: json['linkedin'],
      cv: json['cv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'github': github,
      'linkedin': linkedin,
      'cv': cv
    };
  }
}
