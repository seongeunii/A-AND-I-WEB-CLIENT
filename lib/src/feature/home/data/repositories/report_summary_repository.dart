import 'package:a_and_i_report_web_server/src/core/network/v1_response_parser.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';
import 'package:dio/dio.dart';

/// 과제 목록 데이터를 가져오는 리포지토리입니다.
abstract class ReportSummaryRepository {
  /// 서버로부터 과제 목록을 조회합니다.
  Future<List<ReportSummary>> getReportSummaries(String authorization);
}

/// [ReportSummaryRepository] 구현체입니다.
final class ReportSummaryRepositoryImpl implements ReportSummaryRepository {
  final Dio dio;

  const ReportSummaryRepositoryImpl({required this.dio});

  @override
  Future<List<ReportSummary>> getReportSummaries(String authorization) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/courses',
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      return const <ReportSummary>[];
    }

    return V1ResponseParser.parseList(data, ReportSummary.fromJson);
  }
}
