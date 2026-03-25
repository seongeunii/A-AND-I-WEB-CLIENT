/// 비웹 환경에서 사용하는 제출 스트림 데이터소스 스텁입니다.
class SubmissionStreamRemoteDatasource {
  /// 테스트/비웹 환경에서는 빈 스트림을 반환합니다.
  const SubmissionStreamRemoteDatasource();

  Stream<String> connect({
    required String streamUrl,
    required String accessToken,
  }) {
    return const Stream<String>.empty();
  }
}
