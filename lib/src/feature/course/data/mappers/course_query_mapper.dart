import 'package:a_and_i_report_web_server/src/feature/course/data/dtos/course_assignment_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/dtos/course_week_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_assignment.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_week.dart';

/// [CourseWeekDto]를 [CourseWeek]로 변환합니다.
extension CourseWeekDtoMapper on CourseWeekDto {
  CourseWeek toEntity() {
    return CourseWeek(
      id: id,
      weekNo: weekNo,
      title: title,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// [CourseAssignmentDto]를 [CourseAssignment]로 변환합니다.
extension CourseAssignmentDtoMapper on CourseAssignmentDto {
  CourseAssignment toEntity() {
    return CourseAssignment(
      core: CourseAssignmentCore(
        id: id,
        courseSlug: courseSlug,
        weekNo: weekNo,
        orderInWeek: orderInWeek,
        startAt: startAt,
        endAt: endAt,
        status: status,
        publishedAt: publishedAt,
      ),
      metadata: CourseAssignmentMetadata(
        title: metadata.title,
        difficulty: metadata.difficulty,
        description: metadata.description,
        timeLimitMinutes: metadata.timeLimitMinutes,
        learningGoals: metadata.learningGoals,
        attributes: metadata.attributes,
      ),
    );
  }
}
