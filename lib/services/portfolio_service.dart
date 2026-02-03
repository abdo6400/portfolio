import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/social.dart';

class PortfolioService {
  static const _projectsKey = 'projects';
  static const _skillsKey = 'skills';
  static const _experiencesKey = 'experiences';
  static const _socialsKey = 'socials';
  static const _profileKey = 'profile';

  Future<void> initializeData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load cover.json from assets
      final jsonString = await rootBundle.loadString('assets/cover.json');
      final Map<String, dynamic> coverData = jsonDecode(jsonString);

      // Profile
      final profile = {
        'name': coverData['name'],
        'title': coverData['work_experience'][0]['position']
            .toString()
            .toUpperCase(),
        'bio': coverData['summary'],
        'available': true,
        'yearsExperience': '2+',
        'projectsCount': coverData['projects'].length.toString(),
        'awardsCount': '1',
        'location': coverData['contact_information']['location'],
        'email': coverData['contact_information']['email'],
        'phone': coverData['contact_information']['phone'],
        'imageDesc':
            'assets/images/professional_portrait_developer_null_1770051657797.jpg',
      };
      await prefs.setString(_profileKey, jsonEncode(profile));

      // Projects
      final List<Project> projects = (coverData['projects'] as List)
          .asMap()
          .entries
          .map((e) {
            final index = e.key;
            final p = e.value;
            return Project(
              id: index.toString(),
              title: p['name'],
              category: 'Mobile App',
              description: p['description'],
              imageDesc: _getProjectImage(index),
              techStack: List<String>.from(p['skills_used']),
              createdAt: DateTime.now(),
            );
          })
          .toList();
      await _saveProjects(prefs, projects);

      // Skills
      final List<Skill> skills = [];
      final skillsMap = coverData['skills'] as Map<String, dynamic>;
      int skillId = 1;
      skillsMap.forEach((category, list) {
        for (var name in (list as List)) {
          skills.add(
            Skill(
              id: (skillId++).toString(),
              name: name,
              color: _getCategoryColor(category),
              icon: _getCategoryIcon(category),
              proficiency: 0.9,
              createdAt: DateTime.now(),
            ),
          );
        }
      });
      await _saveSkills(prefs, skills);

      // Socials
      final socialLinks =
          coverData['additional_information']['social_links']
              as Map<String, dynamic>;
      final List<Social> socials = [
        Social(
          id: '1',
          platform: 'GITHUB',
          handle: socialLinks['github'].toString().split('/').last,
          icon: Icons.code_rounded,
          color: Colors.white,
          url: socialLinks['github'],
          createdAt: DateTime.now(),
        ),
        Social(
          id: '2',
          platform: 'LINKEDIN',
          handle: 'Abdulrahman Amr',
          icon: Icons.business_center_rounded,
          color: const Color(0xFF0077B5),
          url: socialLinks['linkedin'],
          createdAt: DateTime.now(),
        ),
        Social(
          id: '3',
          platform: 'EMAIL',
          handle: coverData['contact_information']['email'],
          icon: Icons.mail_outline_rounded,
          color: const Color(0xFFEA4C89),
          url: 'mailto:${coverData['contact_information']['email']}',
          createdAt: DateTime.now(),
        ),
      ];
      await _saveSocials(prefs, socials);

      // Experiences
      final List<Experience> experiences =
          (coverData['work_experience'] as List).asMap().entries.map((e) {
            final index = e.key;
            final exp = e.value;
            return Experience(
              id: index.toString(),
              role: exp['position'],
              company: exp['company'],
              period: exp['duration'],
              description: (exp['responsibilities'] as List).join('\n'),
              dotColor: _getExperienceColor(index),
              createdAt: DateTime.now(),
            );
          }).toList();
      await _saveExperiences(prefs, experiences);
    } catch (e) {
      debugPrint('Failed to load cover.json: $e');
    }
  }

  String _getProjectImage(int index) {
    final images = [
      'assets/images/fintech_app_dashboard_mobile_null_1770051658517.jpg',
      'assets/images/minimalist_online_store_null_1770051659464.jpg',
      'assets/images/fitness_tracker_app_smart_watch_null_1770051663153.jpg',
    ];
    return images[index % images.length];
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'languages':
        return const Color(0xFF22D3EE);
      case 'frameworks':
        return const Color(0xFFFB923C);
      case 'development_practices':
        return const Color(0xFF4ADE80);
      default:
        return const Color(0xFFF472B6);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'languages':
        return Icons.code;
      case 'frameworks':
        return Icons.flutter_dash;
      case 'development_practices':
        return Icons.architecture;
      default:
        return Icons.build;
    }
  }

  Color _getExperienceColor(int index) {
    final colors = [Colors.cyan, Colors.pink, Colors.green, Colors.orange];
    return colors[index % colors.length];
  }

  Future<void> _saveProjects(
    SharedPreferences prefs,
    List<Project> projects,
  ) async {
    final data = jsonEncode(projects.map((e) => e.toJson()).toList());
    await prefs.setString(_projectsKey, data);
  }

  Future<void> _saveSkills(SharedPreferences prefs, List<Skill> skills) async {
    final data = jsonEncode(skills.map((e) => e.toJson()).toList());
    await prefs.setString(_skillsKey, data);
  }

  Future<void> _saveExperiences(
    SharedPreferences prefs,
    List<Experience> experiences,
  ) async {
    final data = jsonEncode(experiences.map((e) => e.toJson()).toList());
    await prefs.setString(_experiencesKey, data);
  }

  Future<void> _saveSocials(
    SharedPreferences prefs,
    List<Social> socials,
  ) async {
    final data = jsonEncode(socials.map((e) => e.toJson()).toList());
    await prefs.setString(_socialsKey, data);
  }

  Future<List<Project>> getProjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_projectsKey);
      if (data == null || data == 'null') return [];
      final decoded = jsonDecode(data);
      if (decoded is! List) return [];
      return decoded
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Skill>> getSkills() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_skillsKey);
      if (data == null || data == 'null') return [];
      final decoded = jsonDecode(data);
      if (decoded is! List) return [];
      return decoded
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Experience>> getExperiences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_experiencesKey);
      if (data == null || data == 'null') return [];
      final decoded = jsonDecode(data);
      if (decoded is! List) return [];
      return decoded
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Social>> getSocials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_socialsKey);
      if (data == null || data == 'null') return [];
      final decoded = jsonDecode(data);
      if (decoded is! List) return [];
      return decoded
          .map((e) => Social.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? profileJson = prefs.getString(_profileKey);
      if (profileJson == null) return null;
      return jsonDecode(profileJson) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
}
