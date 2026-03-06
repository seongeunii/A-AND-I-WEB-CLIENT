import 'package:a_and_i_report_web_server/src/core/widgets/responsive_layout.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/viewModel/course_filter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 홈 UI 상단 헤더 영역

class HomeHeaderView extends ConsumerWidget {
  const HomeHeaderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(courseFilterViewModelProvider);
    final notifier = ref.read(courseFilterViewModelProvider.notifier);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withValues(alpha: 0.25),
                offset: const Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 5.0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "목차",
            style: TextStyle(
                color: const Color(0xff323232),
                fontSize: isMobile ? 18 : 34,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              _FilterDropdown(
                label: '상태',
                value: filter.status,
                options: CourseFilterViewModel.statuses,
                onChanged: notifier.setStatus,
                width: isMobile ? 140 : 180,
              ),
              _FilterDropdown(
                label: '과정 단계',
                value: filter.phase,
                options: CourseFilterViewModel.phases,
                onChanged: notifier.setPhase,
                width: isMobile ? 160 : 200,
              ),
              _FilterDropdown(
                label: '트랙',
                value: filter.track,
                options: CourseFilterViewModel.tracks,
                onChanged: notifier.setTrack,
                width: isMobile ? 140 : 180,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final double width;

  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w600,
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
        ),
        items: <DropdownMenuItem<String>>[
          const DropdownMenuItem<String>(
            value: null,
            child: Text('--'),
          ),
          ...options.map(
            (option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            ),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
