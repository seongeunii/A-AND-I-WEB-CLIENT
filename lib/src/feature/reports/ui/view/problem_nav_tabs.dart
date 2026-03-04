import 'package:flutter/material.dart';

class ProblemNavTabs extends StatelessWidget {
  final ValueNotifier<int> selectedTab;
  final bool isDarkMode;
  const ProblemNavTabs({
    super.key,
    required this.selectedTab,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabItem(
          label: '문제',
          isActive: selectedTab.value == 0,
          onTap: () => selectedTab.value = 0,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 48),
        _TabItem(
          label: '제출',
          isActive: selectedTab.value == 1,
          onTap: () => selectedTab.value = 1,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 48),
        _TabItem(
          label: '결과',
          isActive: selectedTab.value == 2,
          onTap: () => selectedTab.value = 2,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive
                    ? (isDarkMode ? Colors.white : Colors.black)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
