import 'package:a_and_i_report_web_server/src/core/utils/api_error_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/course_repository.dart';

/// 코스 목록 조회 UseCase 인터페이스입니다.
abstract class GetCoursesUsecase {
  Future<List<Course>> call();
}

/// 코스 목록을 조회하는 UseCase 구현체입니다.
final class GetCoursesUsecaseImpl implements GetCoursesUsecase {
  final CourseRepository _courseRepository;
  final AuthRepository _authRepository;

  const GetCoursesUsecaseImpl({
    required CourseRepository courseRepository,
    required AuthRepository authRepository,
  })  : _courseRepository = courseRepository,
        _authRepository = authRepository;

  @override
  Future<List<Course>> call() async {
    final token = await _authRepository.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    final authorization = 'Bearer $token';
    final requests = <({String? status, String? phase, String? track})>[
      (status: null, phase: null, track: null),
      (status: 'PUBLISHED', phase: null, track: null),
      (status: 'PUBLISHED', phase: null, track: 'FL'),
      (status: 'PUBLISHED', phase: 'BASIC', track: 'FL'),
      (status: 'PUBLISHED', phase: 'CS', track: 'FL'),
    ];

    for (final request in requests) {
      try {
        final response = await _courseRepository.getCourses(
          authorization,
          request.status,
          request.phase,
          request.track,
        );

        if (!response.success) {
          throw Exception(
            ApiErrorMapper.mapApiError(
              code: response.error?.code,
              message: response.error?.message,
              fallbackMessage: '코스 목록 조회에 실패했습니다.',
            ),
          );
        }

        if (response.data.isNotEmpty) {
          return _deduplicateCourses(response.data);
        }
      } catch (error) {
        throw Exception(
          ApiErrorMapper.map(
            error,
            fallbackMessage: '코스 목록 조회에 실패했습니다.',
          ),
        );
      }
    }

    return const [];
  }

  List<Course> _deduplicateCourses(List<Course> courses) {
    final uniqueById = <String, Course>{};

    for (final course in courses) {
      uniqueById[course.id] = course;
    }

    return uniqueById.values.toList(growable: false);
  }
}
