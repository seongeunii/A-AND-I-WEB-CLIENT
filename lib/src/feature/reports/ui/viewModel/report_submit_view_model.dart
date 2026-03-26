import 'dart:async';
import 'dart:convert';

import 'package:a_and_i_report_web_server/src/core/utils/api_error_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/create_submission_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_my_problem_submissions_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_submission_result_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/stream_submission_events_usecase_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'report_submit_view_model.freezed.dart';

enum SubmitLanguage { kotlin, dart, python }

enum SubmissionStatus {
  notSubmitted,
  submitting,
  queued,
  judging,
  accepted,
  failed,
  error,
}

@freezed
abstract class ReportSubmitState with _$ReportSubmitState {
  const factory ReportSubmitState({
    required SubmitLanguage selectedLanguage,
    required Map<SubmitLanguage, String> draftCodeByLanguage,
    required Map<SubmitLanguage, String> templateCodeByLanguage,
    @Default(SubmissionStatus.notSubmitted) SubmissionStatus submissionStatus,
    @Default('') String latestSubmittedCode,
    SubmitLanguage? latestSubmittedLanguage,
    DateTime? submittedAt,
    @Default(0) int submitCount,
    @Default(0) int score,
    @Default(<String>[]) List<String> feedbacks,
    @Default(<SubmissionTestCaseResult>[])
    List<SubmissionTestCaseResult> testCaseResults,
    @Default(<SubmissionResult>[]) List<SubmissionResult> previousSubmissions,
    String? submissionId,
    String? streamUrl,
    String? historyProblemId,
    String? latestVerdict,
    @Default(false) bool isSubmitting,
    @Default(false) bool isPolling,
    @Default(false) bool isHistoryLoading,
    @Default(false) bool hasLoadedHistory,
    @Default('') String errorMsg,
    @Default('') String historyErrorMsg,
  }) = _ReportSubmitState;

  factory ReportSubmitState.initial(List<CodeTemplate> codeTemplates) {
    final resolvedTemplates = _resolveTemplateCodeByLanguage(codeTemplates);

    return ReportSubmitState(
      selectedLanguage: SubmitLanguage.kotlin,
      draftCodeByLanguage: resolvedTemplates,
      templateCodeByLanguage: resolvedTemplates,
    );
  }
}

class ReportSubmitViewModel extends StateNotifier<ReportSubmitState> {
  final String reportId;
  final Ref ref;
  StreamSubscription<String>? _submissionStreamSubscription;
  int _submissionStreamSession = 0;

  ReportSubmitViewModel({
    required this.reportId,
    required List<CodeTemplate> codeTemplates,
    required this.ref,
  }) : super(ReportSubmitState.initial(codeTemplates));

  void selectLanguage(SubmitLanguage language) {
    state = state.copyWith(selectedLanguage: language);
  }

  void updateDraft(SubmitLanguage language, String code) {
    state = state.copyWith(
      draftCodeByLanguage: {
        ...state.draftCodeByLanguage,
        language: code,
      },
    );
  }

  void loadTemplateForCurrentLanguage() {
    final lang = state.selectedLanguage;
    updateDraft(lang, state.templateCodeByLanguage[lang] ?? lang.template);
  }

  Future<void> loadSubmissionHistory({
    required String problemId,
    bool forceRefresh = false,
  }) async {
    if (!mounted) {
      return;
    }

    final normalizedProblemId = problemId.trim();
    if (normalizedProblemId.isEmpty ||
        state.isSubmitting ||
        state.isPolling ||
        state.isHistoryLoading) {
      return;
    }

    if (!forceRefresh &&
        state.historyProblemId == normalizedProblemId &&
        (state.hasLoadedHistory || state.historyErrorMsg.isNotEmpty)) {
      return;
    }

    state = state.copyWith(
      isHistoryLoading: true,
      hasLoadedHistory: false,
      historyProblemId: normalizedProblemId,
      historyErrorMsg: '',
    );

    try {
      final previousSubmissions = await ref
          .read(getMyProblemSubmissionsUsecaseProvider)
          .call(normalizedProblemId);
      if (!mounted) {
        return;
      }

      final sortedSubmissions = [...previousSubmissions]..sort((a, b) {
          final aTime = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          final bTime = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          return bTime.compareTo(aTime);
        });

      final latestSubmissionSummary =
          sortedSubmissions.isEmpty ? null : sortedSubmissions.first;
      SubmissionResult? latestSubmissionDetail;
      if (latestSubmissionSummary != null) {
        try {
          latestSubmissionDetail = await ref
              .read(getSubmissionResultUsecaseProvider)
              .call(latestSubmissionSummary.submissionId);
          if (!mounted) {
            return;
          }
        } catch (_) {
          latestSubmissionDetail = null;
        }
      }

      final latestSubmission =
          latestSubmissionDetail == null || latestSubmissionSummary == null
              ? latestSubmissionDetail ?? latestSubmissionSummary
              : _mergeSubmissionSnapshots(
                  summary: latestSubmissionSummary,
                  detail: latestSubmissionDetail,
                );
      final resolvedSubmissions = latestSubmissionDetail == null
          ? sortedSubmissions
          : [
              latestSubmission!,
              ...sortedSubmissions.skip(1),
            ];

      state = state.copyWith(
        isHistoryLoading: false,
        hasLoadedHistory: true,
        previousSubmissions: resolvedSubmissions,
        historyErrorMsg: '',
        submitCount: resolvedSubmissions.length,
      );

      if (latestSubmission != null) {
        _applyHistoricalResultSnapshot(
          latestSubmission,
          submissionCount: resolvedSubmissions.length,
        );
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      state = state.copyWith(
        isHistoryLoading: false,
        historyErrorMsg: ApiErrorMapper.map(
          error,
          fallbackMessage: '이전 채점 기록을 불러오지 못했습니다.',
        ),
      );
    }
  }

  Future<bool> submitCurrentDraft({
    String? problemId,
    bool isDeadlineClosed = false,
  }) async {
    if (!mounted) {
      return false;
    }

    if (isDeadlineClosed) {
      state = state.copyWith(
        isSubmitting: false,
        isPolling: false,
        errorMsg: '마감된 과제는 제출할 수 없습니다.',
      );
      return false;
    }

    final lang = state.selectedLanguage;
    final code = (state.draftCodeByLanguage[lang] ?? '').trim();
    if (code.isEmpty) {
      return false;
    }

    final normalizedProblemId = problemId?.trim();
    if (normalizedProblemId == null || normalizedProblemId.isEmpty) {
      state = state.copyWith(
        isSubmitting: false,
        isPolling: false,
        submissionStatus: SubmissionStatus.error,
        errorMsg: '현재 과제 ID를 확인할 수 없습니다.',
        feedbacks: const <String>['현재 과제 ID를 확인할 수 없습니다.'],
      );
      return false;
    }

    state = state.copyWith(
      isSubmitting: true,
      errorMsg: '',
      historyProblemId: normalizedProblemId,
      latestSubmittedCode: code,
      latestSubmittedLanguage: lang,
      submittedAt: DateTime.now(),
      submitCount: state.submitCount + 1,
      submissionStatus: SubmissionStatus.submitting,
      feedbacks: const <String>['제출 요청을 전송하고 있습니다.'],
      testCaseResults: const <SubmissionTestCaseResult>[],
    );

    try {
      final response = await ref.read(createSubmissionUsecaseProvider).call(
            problemId: normalizedProblemId,
            language: lang.apiValue,
            code: code,
          );
      if (!mounted) {
        return false;
      }

      state = state.copyWith(
        isSubmitting: false,
        isPolling: false,
        submissionId: response.submissionId,
        streamUrl: response.streamUrl,
        submissionStatus: SubmissionStatus.queued,
        feedbacks: const <String>['제출이 접수되었습니다. 결과를 확인하고 있습니다.'],
      );

      final immediateResult =
          await _fetchSubmissionResultSnapshot(response.submissionId);
      if (!mounted) {
        return false;
      }
      if (immediateResult != null) {
        final immediateStatus = _mapSubmissionStatus(immediateResult.status);
        _applyResultSnapshot(
          immediateResult,
          feedbacks: _buildSnapshotFeedbacks(
            result: immediateResult,
            baseFeedbacks: state.feedbacks,
            includeCompletionMessage: _isTerminal(immediateStatus),
          ),
        );

        if (_isTerminal(immediateStatus)) {
          return true;
        }
      } else {
        state = state.copyWith(
          isPolling: true,
          feedbacks: [...state.feedbacks, '채점 스트림을 연결하고 있습니다.'],
        );
      }

      if (response.streamUrl.trim().isEmpty) {
        await _handleStreamTermination(
          submissionId: response.submissionId,
          sessionToken: _submissionStreamSession,
        );
        return true;
      }

      await _startStreaming(
        response.streamUrl,
        submissionId: response.submissionId,
      );
      return true;
    } catch (error) {
      if (!mounted) {
        return false;
      }
      final message = ApiErrorMapper.map(
        error,
        fallbackMessage: '소스 코드 제출에 실패했습니다.',
      );
      state = state.copyWith(
        isSubmitting: false,
        isPolling: false,
        submissionStatus: SubmissionStatus.error,
        errorMsg: message,
        feedbacks: <String>[message],
      );
      return false;
    }
  }

  Future<void> _startStreaming(
    String streamUrl, {
    required String submissionId,
  }) async {
    _cancelSubmissionStream();
    final sessionToken = _submissionStreamSession;
    try {
      final eventStream =
          await ref.read(streamSubmissionEventsUsecaseProvider).call(streamUrl);
      if (!mounted || sessionToken != _submissionStreamSession) {
        return;
      }

      _submissionStreamSubscription = eventStream.listen(
        _handleStreamEvent,
        onError: (error, _) {
          unawaited(
            _handleStreamTermination(
              submissionId: submissionId,
              sessionToken: sessionToken,
              streamError: error,
            ),
          );
        },
        onDone: () {
          unawaited(
            _handleStreamTermination(
              submissionId: submissionId,
              sessionToken: sessionToken,
            ),
          );
        },
      );
      state = state.copyWith(
        isPolling: true,
        feedbacks: [...state.feedbacks, '채점 스트림을 연결하고 있습니다.'],
      );
    } catch (error) {
      await _handleStreamTermination(
        submissionId: submissionId,
        sessionToken: sessionToken,
        streamError: error,
      );
    }
  }

  void _handleStreamEvent(String payload) {
    final envelope = _parseStreamEnvelope(payload);
    if (envelope != null) {
      final eventName = envelope.event;
      final eventData = envelope.data;

      if (eventName == 'test_case_result' &&
          eventData is Map<String, dynamic>) {
        final testCaseResult = _parseTestCaseResult(eventData);
        final nextTestCaseResults = _upsertTestCaseResult(
          state.testCaseResults,
          testCaseResult,
        );
        state = state.copyWith(
          isPolling: true,
          submissionStatus: SubmissionStatus.judging,
          latestVerdict: testCaseResult.status,
          testCaseResults: nextTestCaseResults,
          feedbacks: [
            ...state.feedbacks,
            _formatTestCaseResultLine(testCaseResult),
          ],
          errorMsg: '',
        );
        return;
      }

      if (eventName == 'done' && eventData is Map<String, dynamic>) {
        final overallStatus = eventData['overallStatus']?.toString().trim();
        final submissionId =
            eventData['submissionId']?.toString().trim() ?? state.submissionId;
        if (overallStatus != null && overallStatus.isNotEmpty) {
          final nextStatus = _mapSubmissionStatus(overallStatus);
          final score = _calculateScore(
            testCaseResults: state.testCaseResults,
            finalStatus: nextStatus,
          );
          final historyProblemId = state.historyProblemId;
          _cancelSubmissionStream();
          state = state.copyWith(
            isPolling: false,
            submissionStatus: nextStatus,
            latestVerdict: overallStatus,
            submissionId: submissionId,
            score: score,
            feedbacks: [
              ...state.feedbacks,
              _completionMessage(nextStatus),
            ],
            errorMsg: '',
          );
          if (historyProblemId != null && historyProblemId.isNotEmpty) {
            unawaited(
              loadSubmissionHistory(
                problemId: historyProblemId,
                forceRefresh: true,
              ),
            );
          }
          return;
        }
      }
    }

    final nextFeedbacks = [...state.feedbacks];
    final displayLines = _extractDisplayLines(payload);
    for (final line in displayLines) {
      if (line.trim().isNotEmpty) {
        nextFeedbacks.add(line.trim());
      }
    }

    final result = _parseSubmissionResult(payload);
    if (result != null) {
      _applyResultSnapshot(result, feedbacks: nextFeedbacks);
      return;
    }

    final inferredStatus = _inferStatusFromPayload(payload);
    if (inferredStatus != null) {
      state = state.copyWith(
        isPolling: !_isTerminal(inferredStatus),
        submissionStatus: inferredStatus,
        latestVerdict: payload.trim(),
        feedbacks: nextFeedbacks,
        errorMsg: '',
      );
      return;
    }

    state = state.copyWith(
      feedbacks: nextFeedbacks,
      errorMsg: '',
    );
  }

  void _applyResultSnapshot(
    SubmissionResult result, {
    required List<String> feedbacks,
  }) {
    final nextStatus = _mapSubmissionStatus(result.status);
    final nextTestCaseResults =
        result.testCases.isEmpty ? state.testCaseResults : result.testCases;
    final score = _calculateScore(
      testCaseResults: nextTestCaseResults,
      finalStatus: nextStatus,
    );

    if (_isTerminal(nextStatus)) {
      final historyProblemId = state.historyProblemId;
      _cancelSubmissionStream();
      if (historyProblemId != null && historyProblemId.isNotEmpty) {
        unawaited(
          loadSubmissionHistory(
            problemId: historyProblemId,
            forceRefresh: true,
          ),
        );
      }
    }

    state = state.copyWith(
      isPolling: !_isTerminal(nextStatus),
      submissionStatus: nextStatus,
      latestVerdict: result.status,
      submissionId: result.submissionId,
      submittedAt: result.createdAt ?? state.submittedAt,
      score: score,
      feedbacks: feedbacks,
      testCaseResults: nextTestCaseResults,
      errorMsg: '',
    );
  }

  Future<SubmissionResult?> _fetchSubmissionResultSnapshot(
    String submissionId,
  ) async {
    try {
      return await ref.read(getSubmissionResultUsecaseProvider).call(
            submissionId,
          );
    } catch (_) {
      return null;
    }
  }

  Future<void> _handleStreamTermination({
    required String submissionId,
    required int sessionToken,
    Object? streamError,
  }) async {
    if (!mounted ||
        sessionToken != _submissionStreamSession ||
        state.submissionId != submissionId) {
      return;
    }

    _submissionStreamSession += 1;
    _submissionStreamSubscription = null;

    final snapshot = await _fetchSubmissionResultSnapshot(submissionId);
    if (!mounted) {
      return;
    }
    if (snapshot != null && state.submissionId == submissionId) {
      final nextStatus = _mapSubmissionStatus(snapshot.status);
      _applyResultSnapshot(
        snapshot,
        feedbacks: _buildSnapshotFeedbacks(
          result: snapshot,
          baseFeedbacks: state.feedbacks,
          includeCompletionMessage: _isTerminal(nextStatus),
        ),
      );
      if (_isTerminal(nextStatus)) {
        return;
      }
    }

    if (state.submissionId != submissionId) {
      return;
    }

    if (streamError != null) {
      final message = ApiErrorMapper.map(
        streamError,
        fallbackMessage: '채점 결과를 확인하지 못했습니다.',
      );
      state = state.copyWith(
        isPolling: false,
        submissionStatus: SubmissionStatus.error,
        errorMsg: message,
        feedbacks: [...state.feedbacks, message],
      );
      return;
    }

    state = state.copyWith(isPolling: false);
  }

  List<String> _buildSnapshotFeedbacks({
    required SubmissionResult result,
    required List<String> baseFeedbacks,
    required bool includeCompletionMessage,
  }) {
    final nextFeedbacks = [...baseFeedbacks];
    final normalizedStatus = result.status.trim();
    if (normalizedStatus.isNotEmpty) {
      final statusLine = '상태: $normalizedStatus';
      if (!nextFeedbacks.contains(statusLine)) {
        nextFeedbacks.add(statusLine);
      }
    }

    if (result.testCases.isNotEmpty) {
      for (final testCase in result.testCases) {
        final line = _formatTestCaseResultLine(testCase);
        if (!nextFeedbacks.contains(line)) {
          nextFeedbacks.add(line);
        }
      }
    }

    if (includeCompletionMessage) {
      final completion =
          _completionMessage(_mapSubmissionStatus(result.status));
      if (!nextFeedbacks.contains(completion)) {
        nextFeedbacks.add(completion);
      }
    }

    return nextFeedbacks;
  }

  void _applyHistoricalResultSnapshot(
    SubmissionResult result, {
    required int submissionCount,
  }) {
    final resolvedLanguage = result.language == null
        ? state.latestSubmittedLanguage
        : SubmitLanguageX.fromApiValue(result.language!) ??
            state.latestSubmittedLanguage;
    final feedbacks = _buildHistoricalFeedbacks(result);
    final nextStatus = _mapSubmissionStatus(result.status);
    final score = _calculateScore(
      testCaseResults: result.testCases,
      finalStatus: nextStatus,
    );

    state = state.copyWith(
      isPolling: false,
      submissionStatus: nextStatus,
      latestSubmittedLanguage: resolvedLanguage,
      submittedAt: result.createdAt ?? state.submittedAt,
      submitCount: submissionCount,
      score: score,
      feedbacks: feedbacks,
      testCaseResults: result.testCases,
      submissionId: result.submissionId,
      latestVerdict: result.status,
      errorMsg: '',
    );
  }

  List<String> _buildHistoricalFeedbacks(SubmissionResult result) {
    final feedbacks = <String>['가장 최근 채점 기록을 불러왔습니다.'];
    if (result.testCases.isNotEmpty) {
      feedbacks.addAll(
        result.testCases.map(_formatTestCaseResultLine),
      );
    }
    feedbacks.add(_completionMessage(_mapSubmissionStatus(result.status)));
    return feedbacks;
  }

  SubmissionResult _mergeSubmissionSnapshots({
    required SubmissionResult summary,
    required SubmissionResult detail,
  }) {
    return detail.copyWith(
      problemId: detail.problemId ?? summary.problemId,
      language: detail.language ?? summary.language,
      status: detail.status.isEmpty ? summary.status : detail.status,
      testCases:
          detail.testCases.isEmpty ? summary.testCases : detail.testCases,
      createdAt: detail.createdAt ?? summary.createdAt,
      completedAt: detail.completedAt ?? summary.completedAt,
    );
  }

  SubmissionResult? _parseSubmissionResult(String payload) {
    final decoded = _tryDecodeJson(payload);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    final source = _extractSourceMap(decoded) ?? decoded;
    final status = source['status']?.toString().trim();
    final submissionId =
        source['submissionId']?.toString().trim() ?? state.submissionId;

    if (status == null ||
        status.isEmpty ||
        submissionId == null ||
        submissionId.isEmpty) {
      return null;
    }

    final rawTestCases = source['testCases'];
    final testCases = rawTestCases is List
        ? rawTestCases
            .whereType<Map<String, dynamic>>()
            .map(SubmissionTestCaseResult.fromJson)
            .toList(growable: false)
        : const <SubmissionTestCaseResult>[];

    return SubmissionResult(
      submissionId: submissionId,
      status: status,
      testCases: testCases,
    );
  }

  List<String> _extractDisplayLines(String payload) {
    final trimmed = payload.trim();
    if (trimmed.isEmpty) {
      return const <String>[];
    }

    final decoded = _tryDecodeJson(trimmed);
    if (decoded is Map<String, dynamic>) {
      final source = _extractSourceMap(decoded) ?? decoded;
      final lines = <String>[];

      final message = source['message']?.toString().trim();
      if (message != null && message.isNotEmpty) {
        lines.add(message);
      }

      final status = source['status']?.toString().trim();
      if ((message == null || message.isEmpty) &&
          status != null &&
          status.isNotEmpty) {
        lines.add('상태: $status');
      }

      return lines.isEmpty ? <String>[trimmed] : lines;
    }

    return trimmed
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);
  }

  SubmissionStatus? _inferStatusFromPayload(String payload) {
    final normalized = payload.trim().toUpperCase();
    if (normalized.isEmpty) {
      return null;
    }

    if (normalized.contains('QUEUED') || normalized.contains('PENDING')) {
      return SubmissionStatus.queued;
    }

    if (normalized.contains('RUNNING') || normalized.contains('JUDGING')) {
      return SubmissionStatus.judging;
    }

    if (normalized.contains('ACCEPTED') || normalized.contains('PASSED')) {
      return SubmissionStatus.accepted;
    }

    if (normalized.contains('WRONG_ANSWER') ||
        normalized.contains('COMPILE_ERROR') ||
        normalized.contains('RUNTIME_ERROR') ||
        normalized.contains('TIME_LIMIT_EXCEEDED') ||
        normalized.contains('MEMORY_LIMIT_EXCEEDED') ||
        normalized.contains('FAILED')) {
      return SubmissionStatus.failed;
    }

    return null;
  }

  Object? _tryDecodeJson(String value) {
    try {
      return jsonDecode(value);
    } catch (_) {
      return null;
    }
  }

  SubmissionStatus _mapSubmissionStatus(String rawStatus) {
    final normalized = rawStatus.trim().toUpperCase();
    return switch (normalized) {
      'QUEUED' => SubmissionStatus.queued,
      'PENDING' => SubmissionStatus.queued,
      'RUNNING' => SubmissionStatus.judging,
      'JUDGING' => SubmissionStatus.judging,
      'ACCEPTED' => SubmissionStatus.accepted,
      'PASSED' => SubmissionStatus.accepted,
      'COMPILE_ERROR' => SubmissionStatus.failed,
      'WRONG_ANSWER' => SubmissionStatus.failed,
      'RUNTIME_ERROR' => SubmissionStatus.failed,
      'TIME_LIMIT_EXCEEDED' => SubmissionStatus.failed,
      'MEMORY_LIMIT_EXCEEDED' => SubmissionStatus.failed,
      _ => SubmissionStatus.failed,
    };
  }

  bool _isTerminal(SubmissionStatus status) {
    return switch (status) {
      SubmissionStatus.accepted ||
      SubmissionStatus.failed ||
      SubmissionStatus.error ||
      SubmissionStatus.notSubmitted =>
        true,
      SubmissionStatus.submitting ||
      SubmissionStatus.queued ||
      SubmissionStatus.judging =>
        false,
    };
  }

  _SubmissionStreamEnvelope? _parseStreamEnvelope(String payload) {
    final decoded = _tryDecodeJson(payload);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    final event = decoded['event']?.toString().trim();
    if (event == null || event.isEmpty) {
      return null;
    }

    return _SubmissionStreamEnvelope(
      event: event,
      data: decoded['data'],
    );
  }

  Map<String, dynamic>? _extractSourceMap(Map<String, dynamic> decoded) {
    final eventData = decoded['data'];
    if (eventData is Map<String, dynamic>) {
      return eventData;
    }

    return null;
  }

  SubmissionTestCaseResult _parseTestCaseResult(Map<String, dynamic> json) {
    return SubmissionTestCaseResult(
      caseId: _asInt(json['caseId']),
      status: json['status']?.toString(),
      timeMs: _asDouble(json['timeMs']),
      memoryMb: _asDouble(json['memoryMb']),
      output: json['output']?.toString(),
      error: json['error']?.toString(),
    );
  }

  List<SubmissionTestCaseResult> _upsertTestCaseResult(
    List<SubmissionTestCaseResult> current,
    SubmissionTestCaseResult next,
  ) {
    final nextCaseId = next.caseId;
    if (nextCaseId == null) {
      return [...current, next];
    }

    final copied = [...current];
    final index = copied.indexWhere((item) => item.caseId == nextCaseId);
    if (index >= 0) {
      copied[index] = next;
      return copied;
    }

    copied.add(next);
    copied.sort((a, b) => (a.caseId ?? 0).compareTo(b.caseId ?? 0));
    return copied;
  }

  String _formatTestCaseResultLine(SubmissionTestCaseResult result) {
    final caseLabel =
        result.caseId == null ? '테스트 케이스' : '${result.caseId}번 테스트';
    final status = result.status ?? 'UNKNOWN';
    final metrics = <String>[];
    if (result.timeMs != null) {
      metrics.add('${result.timeMs!.toStringAsFixed(2)}ms');
    }
    if (result.memoryMb != null) {
      metrics.add('${result.memoryMb!.toStringAsFixed(1)}MB');
    }

    if (metrics.isEmpty) {
      return '$caseLabel: $status';
    }

    return '$caseLabel: $status (${metrics.join(', ')})';
  }

  int _calculateScore({
    required List<SubmissionTestCaseResult> testCaseResults,
    required SubmissionStatus finalStatus,
  }) {
    if (testCaseResults.isEmpty) {
      return finalStatus == SubmissionStatus.accepted ? 100 : 0;
    }

    final passedCount =
        testCaseResults.where((testCase) => testCase.status == 'PASSED').length;
    return ((passedCount / testCaseResults.length) * 100).round();
  }

  String _completionMessage(SubmissionStatus status) {
    return switch (status) {
      SubmissionStatus.accepted => '채점이 완료되었습니다. 정답입니다!',
      SubmissionStatus.failed ||
      SubmissionStatus.error =>
        '채점이 완료되었습니다. 오답입니다.',
      SubmissionStatus.notSubmitted ||
      SubmissionStatus.submitting ||
      SubmissionStatus.queued ||
      SubmissionStatus.judging =>
        '채점이 완료되었습니다.',
    };
  }

  int? _asInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  double? _asDouble(Object? value) {
    if (value is double) {
      return value;
    }
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  @override
  void dispose() {
    _cancelSubmissionStream();
    super.dispose();
  }

  void _cancelSubmissionStream() {
    _submissionStreamSession += 1;
    final subscription = _submissionStreamSubscription;
    _submissionStreamSubscription = null;
    if (subscription != null) {
      unawaited(subscription.cancel());
    }
  }
}

class _SubmissionStreamEnvelope {
  const _SubmissionStreamEnvelope({
    required this.event,
    required this.data,
  });

  final String event;
  final Object? data;
}

final reportSubmitViewModelProvider = StateNotifierProvider.family<
    ReportSubmitViewModel, ReportSubmitState, Report>(
  (ref, report) => ReportSubmitViewModel(
    reportId: report.id,
    codeTemplates: report.codeTemplates,
    ref: ref,
  ),
);

Map<SubmitLanguage, String> _resolveTemplateCodeByLanguage(
  List<CodeTemplate> codeTemplates,
) {
  final templates = <SubmitLanguage, String>{
    SubmitLanguage.kotlin: SubmitLanguage.kotlin.template,
    SubmitLanguage.dart: SubmitLanguage.dart.template,
    SubmitLanguage.python: SubmitLanguage.python.template,
  };

  for (final codeTemplate in codeTemplates) {
    final language = SubmitLanguageX.fromApiValue(codeTemplate.language);
    if (language == null) {
      continue;
    }

    templates[language] = codeTemplate.functionTemplate;
  }

  return templates;
}

extension SubmitLanguageX on SubmitLanguage {
  static SubmitLanguage? fromApiValue(String rawLanguage) {
    final normalized = rawLanguage.trim().toUpperCase();
    return switch (normalized) {
      'KOTLIN' => SubmitLanguage.kotlin,
      'DART' => SubmitLanguage.dart,
      'PYTHON' => SubmitLanguage.python,
      _ => null,
    };
  }

  String get label => switch (this) {
        SubmitLanguage.kotlin => 'Kotlin',
        SubmitLanguage.dart => 'Dart',
        SubmitLanguage.python => 'Python',
      };

  String get key => switch (this) {
        SubmitLanguage.kotlin => 'kotlin',
        SubmitLanguage.dart => 'dart',
        SubmitLanguage.python => 'python',
      };

  String get apiValue => switch (this) {
        SubmitLanguage.kotlin => 'KOTLIN',
        SubmitLanguage.dart => 'DART',
        SubmitLanguage.python => 'PYTHON',
      };

  String get template => switch (this) {
        SubmitLanguage.kotlin => '''
fun main() {
    val command = readln()
    println(command)
}''',
        SubmitLanguage.dart => '''
void main() {
    final command = 'ADD 1';
    print(command);
}''',
        SubmitLanguage.python => '''
def solution(a, b):
    return a + b''',
      };
}
