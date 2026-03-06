import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_detail.dart';

/// 코스 상세 조회를 위한 리포지토리 인터페이스입니다.
abstract class CourseDetailRepository {
  /// 코스 슬러그로 코스 상세 정보를 조회합니다.
  Future<CourseDetail?> getCourseDetail({
    required String authorization,
    required String courseSlug,
  });
}
