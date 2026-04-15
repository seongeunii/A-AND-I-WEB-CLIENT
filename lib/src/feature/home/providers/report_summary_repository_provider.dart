import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/report_summary_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/report_summary_repository_adapter.dart';
import 'package:a_and_i_report_web_server/src/core/constants/api_url.dart';
import 'package:aandi_course_api/aandi_course_api.dart' as course_api;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_summary_repository_provider.g.dart';

@riverpod
ReportSummaryRepository reportSummaryRepository(Ref ref) {
  return ReportSummaryRepositoryAdapter(
    client: course_api.CourseApiClient(
      baseUrl: baseUrl,
    ),
  );
}
