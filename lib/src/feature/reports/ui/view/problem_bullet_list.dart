import 'package:flutter/material.dart';

class ProblemBulletList extends StatelessWidget {
  final List<String> items;
  final bool isDarkMode;
  const ProblemBulletList({
    super.key,
    required this.items,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    size: 10,
                    color: isDarkMode ? const Color(0xFFE5E7EB) : const Color(0xFF000000),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? const Color(0xFFE5E7EB) : const Color(0xFF000000),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
