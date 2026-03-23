import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/submission_repository.dart';

/// 특정 문제에 대한 내 제출 이력을 조회하는 UseCase 구현체입니다.
final class GetMyProblemSubmissionsUsecaseImpl
    implements GetMyProblemSubmissionsUsecase {
  const GetMyProblemSubmissionsUsecaseImpl({
    required this.submissionRepository,
    required this.authRepository,
  });

  final SubmissionRepository submissionRepository;
  final AuthRepository authRepository;

  @override
  Future<List<SubmissionResult>> call(String problemId) async {
    final token = await authRepository.getToken();

    final response = await submissionRepository.getMyProblemSubmissions(
      problemId,
      'Bearer $token',
    );

    return response
        .map((submission) => submission.toEntity())
        .toList(growable: false);
  }
}

/// 특정 문제에 대한 내 제출 이력을 조회하는 UseCase 인터페이스입니다.
abstract class GetMyProblemSubmissionsUsecase {
  Future<List<SubmissionResult>> call(String problemId);
}
