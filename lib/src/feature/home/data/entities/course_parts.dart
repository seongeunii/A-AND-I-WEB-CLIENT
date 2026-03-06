import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';

/// 코스 코어 필드를 묶은 모델입니다.
class CourseCore {
  final String id;
  final String slug;
  final String fieldTag;
  final String startDate;
  final String endDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseCore({
    required this.id,
    required this.slug,
    required this.fieldTag,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}

/// [Course]를 코어 + 메타데이터 구조로 접근하기 위한 확장입니다.
extension CourseCoreMetadataX on Course {
  CourseCore get core => CourseCore(
        id: id,
        slug: slug,
        fieldTag: fieldTag,
        startDate: startDate,
        endDate: endDate,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
