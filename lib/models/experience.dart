import 'package:flutter/material.dart';

class Experience {
  final String id;
  final String role;
  final String company;
  final String period;
  final String description;
  final Color dotColor;
  final DateTime createdAt;

  Experience({
    required this.id,
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.dotColor,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'company': company,
    'period': period,
    'description': description,
    'dotColor': dotColor.value,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json['id'] as String,
    role: json['role'] as String,
    company: json['company'] as String,
    period: json['period'] as String,
    description: json['description'] as String,
    dotColor: Color(json['dotColor'] as int),
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Experience copyWith({
    String? id,
    String? role,
    String? company,
    String? period,
    String? description,
    Color? dotColor,
    DateTime? createdAt,
  }) => Experience(
    id: id ?? this.id,
    role: role ?? this.role,
    company: company ?? this.company,
    period: period ?? this.period,
    description: description ?? this.description,
    dotColor: dotColor ?? this.dotColor,
    createdAt: createdAt ?? this.createdAt,
  );
}
