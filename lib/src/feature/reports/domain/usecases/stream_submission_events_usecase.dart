import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/datasources/submission_stream_remote_datasource.dart';

/// 제출 결과 SSE 이벤트를 구독하는 유스케이스입니다.
final class StreamSubmissionEventsUsecaseImpl
    implements StreamSubmissionEventsUsecase {
  const StreamSubmissionEventsUsecaseImpl({
    required this.authRepository,
    required this.submissionStreamRemoteDatasource,
  });

  final AuthRepository authRepository;
  final SubmissionStreamRemoteDatasource submissionStreamRemoteDatasource;

  @override
  Future<Stream<String>> call(String streamUrl) async {
    final token = await authRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    return submissionStreamRemoteDatasource.connect(
      streamUrl: streamUrl,
      accessToken: token,
    );
  }
}

/// 제출 결과 SSE 이벤트 구독 유스케이스 인터페이스입니다.
abstract class StreamSubmissionEventsUsecase {
  Future<Stream<String>> call(String streamUrl);
}
