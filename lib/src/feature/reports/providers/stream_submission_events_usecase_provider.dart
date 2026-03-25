import 'package:a_and_i_report_web_server/src/feature/auth/providers/auth_repository_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/datasources/submission_stream_remote_datasource_stub.dart'
    if (dart.library.js_interop) 'package:a_and_i_report_web_server/src/feature/reports/data/datasources/submission_stream_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/stream_submission_events_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 제출 결과 스트림 데이터소스 Provider입니다.
final submissionStreamRemoteDatasourceProvider =
    Provider<SubmissionStreamRemoteDatasource>(
  (ref) => const SubmissionStreamRemoteDatasource(),
);

/// 제출 결과 SSE 구독 유스케이스 Provider입니다.
final streamSubmissionEventsUsecaseProvider =
    Provider<StreamSubmissionEventsUsecase>(
  (ref) => StreamSubmissionEventsUsecaseImpl(
    authRepository: ref.read(authRepositoryProvider),
    submissionStreamRemoteDatasource: ref.read(
      submissionStreamRemoteDatasourceProvider,
    ),
  ),
);
