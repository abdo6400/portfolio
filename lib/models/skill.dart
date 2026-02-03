import 'package:flutter/material.dart';

class Skill {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final double proficiency;
  final DateTime createdAt;

  Skill({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.proficiency,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'color': color.value,
    'icon': icon.codePoint,
    'proficiency': proficiency,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json['id'] as String,
    name: json['name'] as String,
    color: Color(json['color'] as int),
    icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
    proficiency: (json['proficiency'] as num).toDouble(),
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Skill copyWith({
    String? id,
    String? name,
    Color? color,
    IconData? icon,
    double? proficiency,
    DateTime? createdAt,
  }) => Skill(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    icon: icon ?? this.icon,
    proficiency: proficiency ?? this.proficiency,
    createdAt: createdAt ?? this.createdAt,
  );
}
