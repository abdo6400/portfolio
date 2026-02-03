import 'package:flutter/material.dart';

class Social {
  final String id;
  final String platform;
  final String handle;
  final IconData icon;
  final Color color;
  final String url;
  final DateTime createdAt;

  Social({
    required this.id,
    required this.platform,
    required this.handle,
    required this.icon,
    required this.color,
    required this.url,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'platform': platform,
    'handle': handle,
    'icon': icon.codePoint,
    'color': color.value,
    'url': url,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    id: json['id'] as String,
    platform: json['platform'] as String,
    handle: json['handle'] as String,
    icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
    color: Color(json['color'] as int),
    url: json['url'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Social copyWith({
    String? id,
    String? platform,
    String? handle,
    IconData? icon,
    Color? color,
    String? url,
    DateTime? createdAt,
  }) => Social(
    id: id ?? this.id,
    platform: platform ?? this.platform,
    handle: handle ?? this.handle,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    url: url ?? this.url,
    createdAt: createdAt ?? this.createdAt,
  );
}
