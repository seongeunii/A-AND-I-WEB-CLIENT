import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/create_submission_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/get_my_problem_submissions_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/get_submission_result_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/stream_submission_events_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/create_submission_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_my_problem_submissions_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_submission_result_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/stream_submission_events_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/viewModel/report_submit_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('ReportSubmitViewModel.loadSubmissionHistory', () {
    test('최신 제출 상세 결과를 다시 조회해 화면 상태를 복원한다', () async {
      final fakeHistoryUsecase = FakeGetMyProblemSubmissionsUsecase(
        results: <SubmissionResult>[
          SubmissionResult(
            submissionId: 'submission-1',
            problemId: 'problem-1',
            language: 'KOTLIN',
            status: 'WRONG_ANSWER',
            createdAt: DateTime.parse('2026-03-24T12:00:00Z'),
          ),
          SubmissionResult(
            submissionId: 'submission-2',
            problemId: 'problem-1',
            language: 'PYTHON',
            status: 'ACCEPTED',
            createdAt: DateTime.parse('2026-03-24T13:00:00Z'),
          ),
        ],
      );
      final fakeDetailUsecase = FakeGetSubmissionResultUsecase(
        responses: <String, SubmissionResult>{
          'submission-2': SubmissionResult(
            submissionId: 'submission-2',
            problemId: 'problem-1',
            language: 'PYTHON',
            status: 'ACCEPTED',
            createdAt: DateTime.parse('2026-03-24T13:00:00Z'),
            completedAt: DateTime.parse('2026-03-24T13:00:05Z'),
            testCases: const <SubmissionTestCaseResult>[
              SubmissionTestCaseResult(caseId: 1, status: 'PASSED'),
              SubmissionTestCaseResult(caseId: 2, status: 'PASSED'),
            ],
          ),
        },
      );
      final report = _buildReport();
      final container = ProviderContainer(
        overrides: [
          getMyProblemSubmissionsUsecaseProvider.overrideWith(
            (ref) => fakeHistoryUsecase,
          ),
          getSubmissionResultUsecaseProvider.overrideWith(
            (ref) => fakeDetailUsecase,
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(reportSubmitViewModelProvider(report).notifier);

      await notifier.loadSubmissionHistory(problemId: 'problem-1');

      final state = container.read(reportSubmitViewModelProvider(report));
      expect(fakeHistoryUsecase.requestedProblemIds, <String>['problem-1']);
      expect(
          fakeDetailUsecase.requestedSubmissionIds, <String>['submission-2']);
      expect(
          state.previousSubmissions.map((item) => item.submissionId), <String>[
        'submission-2',
        'submission-1',
      ]);
      expect(state.previousSubmissions.first.testCases, hasLength(2));
      expect(state.submissionStatus, SubmissionStatus.accepted);
      expect(state.score, 100);
      expect(state.submitCount, 2);
      expect(state.submittedAt, DateTime.parse('2026-03-24T13:00:00Z'));
      expect(state.latestSubmittedLanguage, SubmitLanguage.python);
      expect(state.submissionId, 'submission-2');
      expect(state.testCaseResults, hasLength(2));
      expect(state.feedbacks, contains('가장 최근 채점 기록을 불러왔습니다.'));
      expect(state.feedbacks.last, '채점이 완료되었습니다. 정답입니다!');
      expect(state.hasLoadedHistory, isTrue);
      expect(state.historyErrorMsg, isEmpty);
    });

    test('제출 이력이 없으면 상세 조회 없이 빈 히스토리만 유지한다', () async {
      final fakeHistoryUsecase = FakeGetMyProblemSubmissionsUsecase(
        results: const <SubmissionResult>[],
      );
      final fakeDetailUsecase = FakeGetSubmissionResultUsecase(
        responses: const <String, SubmissionResult>{},
      );
      final report = _buildReport();
      final container = ProviderContainer(
        overrides: [
          getMyProblemSubmissionsUsecaseProvider.overrideWith(
            (ref) => fakeHistoryUsecase,
          ),
          getSubmissionResultUsecaseProvider.overrideWith(
            (ref) => fakeDetailUsecase,
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(reportSubmitViewModelProvider(report).notifier);

      await notifier.loadSubmissionHistory(problemId: 'problem-1');

      final state = container.read(reportSubmitViewModelProvider(report));
      expect(fakeDetailUsecase.requestedSubmissionIds, isEmpty);
      expect(state.previousSubmissions, isEmpty);
      expect(state.submissionStatus, SubmissionStatus.notSubmitted);
      expect(state.submitCount, 0);
      expect(state.hasLoadedHistory, isTrue);
      expect(state.historyErrorMsg, isEmpty);
    });
  });

  group('ReportSubmitViewModel.submitCurrentDraft', () {
    test('마감된 과제는 제출을 시도하지 않는다', () async {
      final fakeCreateUsecase = FakeCreateSubmissionUsecase(
        response: const SubmissionResponseDto(
          submissionId: 'submission-closed',
          streamUrl: '/streams/submission-closed',
        ),
      );
      final report = _buildReport();
      final container = ProviderContainer(
        overrides: [
          createSubmissionUsecaseProvider.overrideWith((ref) {
            return fakeCreateUsecase;
          }),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(reportSubmitViewModelProvider(report).notifier);
      notifier.updateDraft(SubmitLanguage.python, 'print("closed")');

      final submitted = await notifier.submitCurrentDraft(
        problemId: 'problem-1',
        isDeadlineClosed: true,
      );

      final state = container.read(reportSubmitViewModelProvider(report));
      expect(submitted, isFalse);
      expect(fakeCreateUsecase.requestedProblemIds, isEmpty);
      expect(state.errorMsg, '마감된 과제는 제출할 수 없습니다.');
    });

    test('캐시된 최종 결과가 즉시 조회되면 스트림 없이 화면 상태를 갱신한다', () async {
      final fakeCreateUsecase = FakeCreateSubmissionUsecase(
        response: const SubmissionResponseDto(
          submissionId: 'submission-cached',
          streamUrl: '/streams/submission-cached',
        ),
      );
      final fakeDetailUsecase = FakeGetSubmissionResultUsecase(
        responses: const <String, SubmissionResult?>{},
        responseQueues: <String, List<SubmissionResult?>>{
          'submission-cached': <SubmissionResult?>[
            SubmissionResult(
              submissionId: 'submission-cached',
              problemId: 'problem-1',
              language: 'PYTHON',
              status: 'ACCEPTED',
              createdAt: DateTime.parse('2026-03-25T13:00:00Z'),
              completedAt: DateTime.parse('2026-03-25T13:00:02Z'),
              testCases: const <SubmissionTestCaseResult>[
                SubmissionTestCaseResult(caseId: 1, status: 'PASSED'),
                SubmissionTestCaseResult(caseId: 2, status: 'PASSED'),
              ],
            ),
          ],
        },
      );
      final fakeStreamUsecase = FakeStreamSubmissionEventsUsecase(
        streams: <String, Stream<String>>{
          '/streams/submission-cached': const Stream<String>.empty(),
        },
      );
      final report = _buildReport();
      final container = ProviderContainer(
        overrides: [
          createSubmissionUsecaseProvider.overrideWith((ref) {
            return fakeCreateUsecase;
          }),
          getSubmissionResultUsecaseProvider.overrideWith((ref) {
            return fakeDetailUsecase;
          }),
          streamSubmissionEventsUsecaseProvider.overrideWith((ref) {
            return fakeStreamUsecase;
          }),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(reportSubmitViewModelProvider(report).notifier);
      notifier.updateDraft(SubmitLanguage.python, 'print("cached")');

      final submitted =
          await notifier.submitCurrentDraft(problemId: 'problem-1');

      final state = container.read(reportSubmitViewModelProvider(report));
      expect(submitted, isTrue);
      expect(fakeCreateUsecase.requestedProblemIds, <String>['problem-1']);
      expect(
        fakeDetailUsecase.requestedSubmissionIds,
        <String>['submission-cached'],
      );
      expect(fakeStreamUsecase.requestedStreamUrls, isEmpty);
      expect(state.submissionStatus, SubmissionStatus.accepted);
      expect(state.isPolling, isFalse);
      expect(state.testCaseResults, hasLength(2));
      expect(state.feedbacks, contains('채점이 완료되었습니다. 정답입니다!'));
    });

    test('스트림이 바로 종료되어도 최종 결과를 재조회해 화면 상태를 복구한다', () async {
      final fakeCreateUsecase = FakeCreateSubmissionUsecase(
        response: const SubmissionResponseDto(
          submissionId: 'submission-stream',
          streamUrl: '/streams/submission-stream',
        ),
      );
      final fakeDetailUsecase = FakeGetSubmissionResultUsecase(
        responses: const <String, SubmissionResult?>{},
        responseQueues: <String, List<SubmissionResult?>>{
          'submission-stream': <SubmissionResult?>[
            SubmissionResult(
              submissionId: 'submission-stream',
              problemId: 'problem-1',
              language: 'PYTHON',
              status: 'QUEUED',
            ),
            SubmissionResult(
              submissionId: 'submission-stream',
              problemId: 'problem-1',
              language: 'PYTHON',
              status: 'ACCEPTED',
              createdAt: DateTime.parse('2026-03-25T13:10:00Z'),
              completedAt: DateTime.parse('2026-03-25T13:10:03Z'),
              testCases: const <SubmissionTestCaseResult>[
                SubmissionTestCaseResult(caseId: 1, status: 'PASSED'),
              ],
            ),
          ],
        },
      );
      final fakeStreamUsecase = FakeStreamSubmissionEventsUsecase(
        streams: <String, Stream<String>>{
          '/streams/submission-stream': Stream<String>.empty(),
        },
      );
      final report = _buildReport();
      final container = ProviderContainer(
        overrides: [
          createSubmissionUsecaseProvider.overrideWith((ref) {
            return fakeCreateUsecase;
          }),
          getSubmissionResultUsecaseProvider.overrideWith((ref) {
            return fakeDetailUsecase;
          }),
          streamSubmissionEventsUsecaseProvider.overrideWith((ref) {
            return fakeStreamUsecase;
          }),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(reportSubmitViewModelProvider(report).notifier);
      notifier.updateDraft(SubmitLanguage.python, 'print("stream")');

      final submitted =
          await notifier.submitCurrentDraft(problemId: 'problem-1');
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final state = container.read(reportSubmitViewModelProvider(report));
      expect(submitted, isTrue);
      expect(
        fakeDetailUsecase.requestedSubmissionIds,
        <String>['submission-stream', 'submission-stream'],
      );
      expect(
        fakeStreamUsecase.requestedStreamUrls,
        <String>['/streams/submission-stream'],
      );
      expect(state.submissionStatus, SubmissionStatus.accepted);
      expect(state.isPolling, isFalse);
      expect(state.testCaseResults, hasLength(1));
      expect(state.feedbacks, contains('채점이 완료되었습니다. 정답입니다!'));
    });
  });
}

class FakeCreateSubmissionUsecase implements CreateSubmissionUsecase {
  FakeCreateSubmissionUsecase({
    required this.response,
  });

  final SubmissionResponseDto response;
  final List<String> requestedProblemIds = <String>[];
  final List<String> requestedLanguages = <String>[];
  final List<String> requestedCodes = <String>[];

  @override
  Future<SubmissionResponseDto> call({
    required String problemId,
    required String language,
    required String code,
  }) async {
    requestedProblemIds.add(problemId);
    requestedLanguages.add(language);
    requestedCodes.add(code);
    return response;
  }
}

class FakeGetMyProblemSubmissionsUsecase
    implements GetMyProblemSubmissionsUsecase {
  FakeGetMyProblemSubmissionsUsecase({
    required this.results,
  });

  final List<SubmissionResult> results;
  final List<String> requestedProblemIds = <String>[];

  @override
  Future<List<SubmissionResult>> call(String problemId) async {
    requestedProblemIds.add(problemId);
    return results;
  }
}

class FakeGetSubmissionResultUsecase implements GetSubmissionResultUsecase {
  FakeGetSubmissionResultUsecase({
    required this.responses,
    this.responseQueues = const <String, List<SubmissionResult?>>{},
  });

  final Map<String, SubmissionResult?> responses;
  final Map<String, List<SubmissionResult?>> responseQueues;
  final List<String> requestedSubmissionIds = <String>[];

  @override
  Future<SubmissionResult?> call(String submissionId) async {
    requestedSubmissionIds.add(submissionId);
    final queuedResponses = responseQueues[submissionId];
    if (queuedResponses != null && queuedResponses.isNotEmpty) {
      return queuedResponses.removeAt(0);
    }
    return responses[submissionId];
  }
}

class FakeStreamSubmissionEventsUsecase
    implements StreamSubmissionEventsUsecase {
  FakeStreamSubmissionEventsUsecase({
    required this.streams,
  });

  final Map<String, Stream<String>> streams;
  final List<String> requestedStreamUrls = <String>[];

  @override
  Future<Stream<String>> call(String streamUrl) async {
    requestedStreamUrls.add(streamUrl);
    return streams[streamUrl] ?? const Stream<String>.empty();
  }
}

Report _buildReport() {
  return Report(
    id: 'report-1',
    problemId: 'problem-1',
    title: '문제',
    content: '설명',
    requirement: <SeqString>[],
    objects: <SeqString>[],
    exampleIo: <ExampleIO>[],
    codeTemplates: <CodeTemplate>[],
    reportType: ReportType.CS,
    week: 1,
    level: Level.MEDIUM,
  );
}
