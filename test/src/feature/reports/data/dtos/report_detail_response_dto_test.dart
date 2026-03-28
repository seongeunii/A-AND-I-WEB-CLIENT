import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/report_detail_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReportDetailResponseDto', () {
    test('예제 입출력은 metadata.testCases만 파싱한다', () {
      final dto = ReportDetailResponseDto.fromJson({
        'success': true,
        'data': {
          'assignmentId': 'assignment-1',
          'courseSlug': 'flutter-basic-test-4th',
          'weekNo': 1,
          'metadata': {
            'title': 'Hello A&I!',
            'difficulty': 'LOW',
            'description': '설명',
            'testCases': [
              {
                'seq': 1,
                'inputText': '입력',
                'outputText': '신규 출력',
                'visibility': 'PUBLIC',
              },
            ],
            'examples': [
              {
                'seq': 1,
                'inputText': '예전 입력',
                'outputText': '예전 출력',
                'visibility': 'PUBLIC',
              },
            ],
          },
        },
      });

      final report = dto.data;
      expect(report, isNotNull);
      expect(report!.exampleIo, hasLength(1));
      expect(report.exampleIo.first.input, '입력');
      expect(report.exampleIo.first.output, '신규 출력');
    });
  });
}
