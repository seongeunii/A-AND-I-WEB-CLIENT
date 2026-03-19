import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/submission_repository.dart';

/// 제출 최종 결과 조회 UseCase 구현체입니다.
final class GetSubmissionResultUsecaseImpl
    implements GetSubmissionResultUsecase {
  final SubmissionRepository submissionRepository;
  final AuthRepository authRepository;

  const GetSubmissionResultUsecaseImpl({
    required this.submissionRepository,
    required this.authRepository,
  });

  @override
  Future<SubmissionResult?> call(String submissionId) async {
    final token = await authRepository.getToken();

    final response = await submissionRepository.getSubmissionResult(
      submissionId,
      'Bearer $token',
    );
    return response.toEntity();
  }
}

/// 제출 최종 결과 조회 UseCase 인터페이스입니다.
abstract class GetSubmissionResultUsecase {
  Future<SubmissionResult?> call(String submissionId);
}
