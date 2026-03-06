import 'package:a_and_i_report_web_server/src/core/widgets/responsive_layout.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_detail.dart';
import 'package:a_and_i_report_web_server/src/feature/course/ui/viewModel/course_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 코스 슬러그를 받아 코스 상세 정보를 표시하는 UI 위젯입니다.
class CourseDetailBySlugView extends ConsumerWidget {
  final String courseSlug;

  const CourseDetailBySlugView({
    super.key,
    required this.courseSlug,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseDetailAsync =
        ref.watch(courseDetailViewModelProvider(courseSlug));

    return courseDetailAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          '오류가 발생했습니다: ${error.toString()}',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      data: (courseDetail) {
        if (courseDetail == null) {
          return _emptyView(context);
        }

        return _CourseDetailContent(courseDetail: courseDetail);
      },
    );
  }

  Widget _emptyView(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Text(
          '조회 가능한 코스가 없습니다.',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: ResponsiveLayout.isMobile(context) ? 13 : 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CourseDetailContent extends StatelessWidget {
  final CourseDetail courseDetail;

  const _CourseDetailContent({required this.courseDetail});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          courseDetail.metadata.title,
          style: TextStyle(
            color: const Color(0xFF111827),
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          courseDetail.metadata.description,
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '기간: ${courseDetail.startDate} ~ ${courseDetail.endDate}',
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: isMobile ? 12 : 13,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '상태: ${courseDetail.status}',
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
