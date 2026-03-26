/// 과제 제출 마감 여부를 반환합니다.
bool isReportDeadlineClosed(DateTime? endAt, {DateTime? now}) {
  if (endAt == null) {
    return false;
  }

  final currentTime = (now ?? DateTime.now()).toUtc();
  return !endAt.isAfter(currentTime);
}

/// 과제 제출 마감까지 남은 시간을 반환합니다.
Duration remainingUntilReportDeadline(DateTime endAt, {DateTime? now}) {
  final currentTime = (now ?? DateTime.now()).toUtc();
  final diff = endAt.difference(currentTime);

  return diff.isNegative ? Duration.zero : diff;
}
