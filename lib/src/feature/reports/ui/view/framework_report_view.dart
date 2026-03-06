import 'package:a_and_i_report_web_server/src/core/widgets/responsive_layout.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/framework_report_list_view.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/viewModel/course_phase_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// FRAMEWORK 과정 뷰
class FrameworkReportView extends ConsumerWidget {
  const FrameworkReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(
      coursePhaseViewModelProvider(
        phase: 'FRAMEWORK',
      ),
    );

    final statusLabel = courseAsync.maybeWhen(
      data: (course) => course?.status ?? '-',
      orElse: () => '...',
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveLayout.isMobile(context) ? 16 : 20,
        horizontal: ResponsiveLayout.isMobile(context) ? 14 : 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFFFFFFF),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 8),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context, statusLabel),
          SizedBox(height: ResponsiveLayout.isMobile(context) ? 16 : 20),
          const FrameworkReportListView(),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, String statusLabel) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: isMobile ? 32 : 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FRAMEWORK 과정",
                      style: TextStyle(
                        color: const Color(0xFF111827),
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Framework Development",
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: isMobile ? 12 : 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: statusLabel == 'ARCHIVED'
                ? const Color(0xFFEEF2FF)
                : const Color(0xFFF4F4F5),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: statusLabel == 'ARCHIVED'
                  ? const Color(0xFFC7D2FE)
                  : const Color(0xFFE4E4E7),
            ),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              color: statusLabel == 'ARCHIVED'
                  ? const Color(0xFF4338CA)
                  : const Color(0xFF6B7280),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
