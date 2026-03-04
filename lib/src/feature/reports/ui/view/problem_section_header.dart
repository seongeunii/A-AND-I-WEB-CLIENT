import 'package:flutter/material.dart';

class ProblemSectionHeader extends StatelessWidget {
  final String label;
  final bool isDarkMode;
  const ProblemSectionHeader({
    super.key,
    required this.label,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? const Color(0xFFF5F5F5) : const Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 16),
        Divider(
          color: isDarkMode ? const Color(0xFF27272A) : const Color(0xFFF3F4F6),
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }
}
