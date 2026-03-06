import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';

/// 과제 요약의 코어 필드를 묶은 모델입니다.
class ReportSummaryCore {
  final String id;
  final int week;
  final int seq;
  final DateTime endAt;

  const ReportSummaryCore({
    required this.id,
    required this.week,
    required this.seq,
    required this.endAt,
  });
}

/// 과제 요약의 메타데이터 필드를 묶은 모델입니다.
class ReportSummaryMetadata {
  final String title;
  final Level level;
  final ReportType reportType;

  const ReportSummaryMetadata({
    required this.title,
    required this.level,
    required this.reportType,
  });
}

/// [ReportSummary]를 코어 + 메타데이터 구조로 접근하기 위한 확장입니다.
extension ReportSummaryCoreMetadataX on ReportSummary {
  ReportSummaryCore get core => ReportSummaryCore(
        id: id,
        week: week,
        seq: seq,
        endAt: endAt,
      );

  ReportSummaryMetadata get metadata => ReportSummaryMetadata(
        title: title,
        level: level,
        reportType: reportType,
      );
}
