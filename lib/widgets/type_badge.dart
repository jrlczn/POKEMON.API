// lib/widgets/type_badge.dart
import 'package:flutter/material.dart';
import '../utils/type_colors.dart';

class TypeBadge extends StatelessWidget {
  final String type;
  final double? fontSize;

  const TypeBadge({super.key, required this.type, this.fontSize});

  @override
  Widget build(BuildContext context) {
    final color = typeColors[type.toLowerCase()] ?? Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize ?? 12,
        ),
      ),
    );
  }
}
