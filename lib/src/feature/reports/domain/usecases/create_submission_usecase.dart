import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_request_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/submission_repository.dart';

/// 제출 생성 UseCase 구현체입니다.
final class CreateSubmissionUsecaseImpl implements CreateSubmissionUsecase {
  final SubmissionRepository submissionRepository;
  final AuthRepository authRepository;

  const CreateSubmissionUsecaseImpl({
    required this.submissionRepository,
    required this.authRepository,
  });

  @override
  Future<SubmissionResponseDto> call({
    required String problemId,
    required String language,
    required String code,
  }) async {
    final token = await authRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    var publicCode = (await authRepository.getCachedUser())?.publicCode?.trim();
    if (publicCode == null || publicCode.isEmpty) {
      final user = await authRepository.getMyInfo(token);
      await authRepository.saveCachedUser(user);
      publicCode = user.publicCode?.trim();
    }

    if (publicCode == null || publicCode.isEmpty) {
      throw Exception('사용자 publicCode를 확인할 수 없습니다.');
    }

    final request = SubmissionRequestDto(
      publicCode: publicCode,
      problemId: problemId,
      language: language,
      code: code,
      options: const SubmissionOptionsDto(
        realtimeFeedback: true,
      ),
    ).toJson();

    return await submissionRepository.createSubmission(
      'Bearer $token',
      'application/json',
      'application/json',
      request,
    );
  }
}

/// 제출 생성 UseCase 인터페이스입니다.
abstract class CreateSubmissionUsecase {
  Future<SubmissionResponseDto> call({
    required String problemId,
    required String language,
    required String code,
  });
}
