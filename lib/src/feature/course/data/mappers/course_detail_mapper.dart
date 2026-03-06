import 'package:a_and_i_report_web_server/src/feature/course/data/dtos/course_detail_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_detail.dart';

/// [CourseDetailDto]를 [CourseDetail]로 변환합니다.
extension CourseDetailDtoMapper on CourseDetailDto {
  CourseDetail toEntity() {
    return CourseDetail(
      core: CourseDetailCore(
        id: id,
        slug: slug,
        fieldTag: fieldTag,
        startDate: startDate,
        endDate: endDate,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      ),
      metadata: CourseDetailMetadata(
        title: metadata.title,
        description: metadata.description,
        phase: metadata.phase,
        attributes: metadata.attributes,
      ),
      additional: CourseDetailAdditional(
        title: title,
        description: description,
        phase: phase,
        targetTrack: targetTrack,
      ),
    );
  }
}
