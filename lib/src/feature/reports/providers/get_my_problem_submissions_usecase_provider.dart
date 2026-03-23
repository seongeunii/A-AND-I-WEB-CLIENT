import 'package:a_and_i_report_web_server/src/feature/auth/providers/auth_repository_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/get_my_problem_submissions_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/submission_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_my_problem_submissions_usecase_provider.g.dart';

/// 특정 문제에 대한 내 제출 이력 조회 UseCase Provider입니다.
@riverpod
GetMyProblemSubmissionsUsecase getMyProblemSubmissionsUsecase(Ref ref) {
  return GetMyProblemSubmissionsUsecaseImpl(
    submissionRepository: ref.read(submissionRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
  );
}
