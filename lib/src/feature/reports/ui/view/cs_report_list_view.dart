import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:a_and_i_report_web_server/src/core/widgets/responsive_layout.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/viewModel/course_phase_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// CS 과제 목록 뷰
class CsReportListView extends ConsumerWidget {
  const CsReportListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(
      coursePhaseViewModelProvider(
        phase: 'CS',
        track: 'NO',
      ),
    );

    return courseAsync.when(
      data: (course) {
        if (course == null) {
          return _EmptyCourseView();
        }
        return _CourseInfoView(course: course);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text(
          '조회 가능한 코스가 없습니다.',
          style: TextStyle(
            color: const Color(0xffAFAFAF),
            fontSize: ResponsiveLayout.isMobile(context) ? 13 : 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _EmptyCourseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Text(
          '조회 가능한 코스가 없습니다.',
          style: TextStyle(
            color: const Color(0xffAFAFAF),
            fontSize: ResponsiveLayout.isMobile(context) ? 13 : 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CourseInfoView extends StatelessWidget {
  final Course course;

  const _CourseInfoView({required this.course});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.metadata.title,
          style: TextStyle(
            color: const Color(0xFF111827),
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          course.metadata.description,
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '기간: ${course.startDate} ~ ${course.endDate}',
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: isMobile ? 12 : 13,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '트랙: ${_trackLabel(course)}',
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: isMobile ? 12 : 13,
          ),
        ),
      ],
    );
  }

  String _trackLabel(Course course) {
    final raw = (course.targetTrack ?? course.fieldTag).trim().toUpperCase();
    if (raw == 'NO' || raw == 'FL' || raw == 'SP') {
      return raw;
    }
    return 'NO';
  }
}
