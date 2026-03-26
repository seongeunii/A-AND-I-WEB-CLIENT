import 'package:flutter/material.dart';

class ProblemNavTabs extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onSelectTab;
  final bool isDarkMode;
  final bool isSubmitDisabled;
  const ProblemNavTabs({
    super.key,
    required this.selectedTab,
    required this.onSelectTab,
    this.isDarkMode = false,
    this.isSubmitDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabItem(
          label: '문제',
          isActive: selectedTab == 0,
          onTap: () => onSelectTab(0),
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 48),
        _TabItem(
          label: '제출',
          isActive: selectedTab == 1,
          onTap: isSubmitDisabled ? null : () => onSelectTab(1),
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 48),
        _TabItem(
          label: '결과',
          isActive: selectedTab == 2,
          onTap: () => onSelectTab(2),
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
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
        opacity: isActive ? 1.0 : (onTap == null ? 0.2 : 0.4),
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
