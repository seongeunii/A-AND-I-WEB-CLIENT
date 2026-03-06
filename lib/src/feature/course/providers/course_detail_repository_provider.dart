import 'package:a_and_i_report_web_server/src/core/providers/dio_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/repositories/course_detail_repository_impl.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/repositories/course_detail_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_detail_repository_provider.g.dart';

/// 코스 상세 조회 리포지토리를 제공합니다.
@riverpod
CourseDetailRepository courseDetailRepository(Ref ref) {
  return CourseDetailRepositoryImpl(dio: ref.read(dioProvider));
}
