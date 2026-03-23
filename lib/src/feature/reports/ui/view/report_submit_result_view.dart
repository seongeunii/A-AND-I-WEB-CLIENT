import 'dart:async';

import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/viewModel/report_submit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReportSubmitResultView extends HookConsumerWidget {
  final Report report;
  final bool isDarkMode;

  const ReportSubmitResultView({
    super.key,
    required this.report,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportSubmitViewModelProvider(report.id));
    final notifier =
        ref.read(reportSubmitViewModelProvider(report.id).notifier);
    final historyProblemId = _resolveHistoryProblemId(
      report: report,
      state: state,
    );

    useEffect(() {
      if (!state.isSubmitting && !state.isPolling) {
        unawaited(
          notifier.loadSubmissionHistory(problemId: historyProblemId),
        );
      }
      return null;
    }, [historyProblemId, state.isSubmitting, state.isPolling]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '제출 결과',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Color(0xFFF5F5F5) : Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '"${report.title}" 제출 상태를 확인할 수 있습니다.',
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Color(0xFFE5E7EB) : Color(0xFF000000),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        _SummaryCard(state: state, isDarkMode: isDarkMode),
        const SizedBox(height: 20),
        _TestCaseResultsCard(state: state, isDarkMode: isDarkMode),
        const SizedBox(height: 20),
        _LiveLogCard(state: state, isDarkMode: isDarkMode),
        if (state.latestSubmittedCode.isNotEmpty) ...[
          const SizedBox(height: 20),
          _SubmittedCodeCard(state: state, isDarkMode: isDarkMode),
        ],
        if (!state.isSubmitting &&
            !state.isPolling &&
            state.previousSubmissions.isNotEmpty) ...[
          const SizedBox(height: 20),
          _PreviousSubmissionHistoryCard(state: state, isDarkMode: isDarkMode),
        ],
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final ReportSubmitState state;
  final bool isDarkMode;

  const _SummaryCard({required this.state, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final statusMeta = _statusMeta(state.submissionStatus);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
        color: isDarkMode ? const Color(0xFF27272A) : const Color(0xFFFCFCFD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusMeta.backgroundColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusMeta.label,
                  style: TextStyle(
                    color: statusMeta.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              if (state.latestSubmittedLanguage != null)
                Text(
                  '언어: ${state.latestSubmittedLanguage!.label}',
                  style: TextStyle(
                    color: isDarkMode
                        ? const Color(0xFFE5E7EB)
                        : const Color(0xFF000000),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          if (_resultHeadline(state.submissionStatus) case final headline?) ...[
            const SizedBox(height: 14),
            Text(
              headline,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: state.submissionStatus == SubmissionStatus.accepted
                    ? const Color(0xFF15803D)
                    : const Color(0xFFB91C1C),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              _MetricTile(
                label: '점수',
                value: state.submissionStatus ==
                            SubmissionStatus.notSubmitted ||
                        state.submissionStatus == SubmissionStatus.submitting ||
                        state.submissionStatus == SubmissionStatus.queued ||
                        state.submissionStatus == SubmissionStatus.judging
                    ? '-'
                    : '${state.score}',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(width: 12),
              _MetricTile(
                label: '제출 횟수',
                value: '${state.submitCount}',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(width: 12),
              _MetricTile(
                label: '최근 제출',
                value: _formatDateTime(state.submittedAt),
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isDarkMode;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF18181B) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDarkMode
                    ? const Color(0xFFE5E7EB)
                    : const Color(0xFF000000),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode
                    ? const Color(0xFFF5F5F5)
                    : const Color(0xFF000000),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestCaseResultsCard extends StatelessWidget {
  final ReportSubmitState state;
  final bool isDarkMode;

  const _TestCaseResultsCard({required this.state, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
        color: isDarkMode ? const Color(0xFF18181B) : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '실시간 테스트 결과',
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode ? Color(0xFFF5F5F5) : Color(0xFF000000),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            state.testCaseResults.isEmpty
                ? '채점 이벤트가 도착하면 테스트 케이스별 상태가 여기 순서대로 표시됩니다.'
                : '각 테스트 케이스의 상태와 실행 정보를 바로 확인할 수 있습니다.',
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode
                  ? const Color(0xFFD4D4D8)
                  : const Color(0xFF4B5563),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          if (state.testCaseResults.isEmpty)
            _EmptyResultState(
              isDarkMode: isDarkMode,
              submissionStatus: state.submissionStatus,
            ),
          if (state.testCaseResults.isNotEmpty)
            ...state.testCaseResults.map(
              (result) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _TestCaseResultRow(
                  result: result,
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LiveLogCard extends StatelessWidget {
  final ReportSubmitState state;
  final bool isDarkMode;

  const _LiveLogCard({required this.state, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final feedbacks = _displayFeedbacks(state.feedbacks);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
        color: isDarkMode ? const Color(0xFF18181B) : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '진행 로그',
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode ? Color(0xFFF5F5F5) : Color(0xFF000000),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          if (feedbacks.isEmpty)
            Text(
              state.submissionStatus == SubmissionStatus.submitting ||
                      state.submissionStatus == SubmissionStatus.queued ||
                      state.submissionStatus == SubmissionStatus.judging
                  ? '채점 서버에 연결 중입니다.'
                  : '아직 표시할 로그가 없습니다.',
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode
                    ? const Color(0xFFE5E7EB)
                    : const Color(0xFF000000),
                height: 1.6,
              ),
            ),
          if (feedbacks.isNotEmpty)
            ...feedbacks.asMap().entries.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(
                      bottom: entry.key == feedbacks.length - 1 ? 0 : 10,
                    ),
                    child: _LogRow(
                      message: entry.value,
                      isDarkMode: isDarkMode,
                      isLatest: entry.key == feedbacks.length - 1,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _EmptyResultState extends StatelessWidget {
  final bool isDarkMode;
  final SubmissionStatus submissionStatus;

  const _EmptyResultState({
    required this.isDarkMode,
    required this.submissionStatus,
  });

  @override
  Widget build(BuildContext context) {
    final isInFlight = submissionStatus == SubmissionStatus.submitting ||
        submissionStatus == SubmissionStatus.queued ||
        submissionStatus == SubmissionStatus.judging;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF27272A) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isInFlight
                  ? const Color(0xFFDBEAFE)
                  : (isDarkMode
                      ? const Color(0xFF3F3F46)
                      : const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isInFlight ? Icons.bolt_rounded : Icons.inbox_rounded,
              color: isInFlight
                  ? const Color(0xFF1D4ED8)
                  : (isDarkMode
                      ? const Color(0xFFE4E4E7)
                      : const Color(0xFF6B7280)),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isInFlight
                  ? '첫 번째 테스트 결과를 기다리는 중입니다.'
                  : '제출 후 결과가 쌓이면 이 영역이 자동으로 채워집니다.',
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode
                    ? const Color(0xFFE5E7EB)
                    : const Color(0xFF111827),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestCaseResultRow extends StatelessWidget {
  final SubmissionTestCaseResult result;
  final bool isDarkMode;

  const _TestCaseResultRow({
    required this.result,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final statusMeta = _testCaseStatusMeta(result.status);
    final detailText = result.error?.trim().isNotEmpty == true
        ? result.error!.trim()
        : result.output?.trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF27272A) : const Color(0xFFFCFCFD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: statusMeta.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  statusMeta.icon,
                  color: statusMeta.textColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            result.caseId == null
                                ? '테스트 케이스'
                                : '테스트 케이스 ${result.caseId}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? const Color(0xFFF5F5F5)
                                  : const Color(0xFF111827),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusMeta.backgroundColor,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            statusMeta.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: statusMeta.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (result.timeMs != null)
                          _MetricChip(
                            label: '${result.timeMs!.toStringAsFixed(2)} ms',
                            icon: Icons.timer_outlined,
                            isDarkMode: isDarkMode,
                          ),
                        if (result.memoryMb != null)
                          _MetricChip(
                            label: '${result.memoryMb!.toStringAsFixed(1)} MB',
                            icon: Icons.memory_rounded,
                            isDarkMode: isDarkMode,
                          ),
                        _MetricChip(
                          label: result.status?.toUpperCase() ?? 'UNKNOWN',
                          icon: Icons.flag_outlined,
                          isDarkMode: isDarkMode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (detailText != null && detailText.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF18181B)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                detailText,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.6,
                  color: isDarkMode
                      ? const Color(0xFFE4E4E7)
                      : const Color(0xFF334155),
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isDarkMode;

  const _MetricChip({
    required this.label,
    required this.icon,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF18181B) : Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color:
                isDarkMode ? const Color(0xFFD4D4D8) : const Color(0xFF4B5563),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDarkMode
                  ? const Color(0xFFF5F5F5)
                  : const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogRow extends StatelessWidget {
  final String message;
  final bool isDarkMode;
  final bool isLatest;

  const _LogRow({
    required this.message,
    required this.isDarkMode,
    required this.isLatest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isLatest
            ? (isDarkMode ? const Color(0xFF27272A) : const Color(0xFFF8FAFC))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: isLatest
                  ? const Color(0xFFDBEAFE)
                  : (isDarkMode
                      ? const Color(0xFF3F3F46)
                      : const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Icon(
              isLatest ? Icons.bolt_rounded : Icons.fiber_manual_record_rounded,
              size: isLatest ? 14 : 10,
              color: isLatest
                  ? const Color(0xFF1D4ED8)
                  : (isDarkMode
                      ? const Color(0xFFE4E4E7)
                      : const Color(0xFF6B7280)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode
                    ? const Color(0xFFE5E7EB)
                    : const Color(0xFF111827),
                height: 1.6,
                fontWeight: isLatest ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmittedCodeCard extends StatelessWidget {
  final ReportSubmitState state;
  final bool isDarkMode;

  const _SubmittedCodeCard({required this.state, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final languageMeta = _languageEffectMeta(
      state.latestSubmittedLanguage?.apiValue,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: languageMeta.accentColor.withValues(alpha: 0.55),
        ),
        color: isDarkMode
            ? languageMeta.darkSurfaceColor
            : languageMeta.lightSurfaceColor,
        boxShadow: [
          BoxShadow(
            color: languageMeta.accentColor.withValues(alpha: 0.14),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '최근 제출 코드',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDarkMode
                        ? const Color(0xFFF5F5F5)
                        : const Color(0xFF000000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (state.latestSubmittedLanguage != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: languageMeta.accentColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: languageMeta.accentColor.withValues(alpha: 0.32),
                    ),
                  ),
                  child: Text(
                    state.latestSubmittedLanguage!.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: languageMeta.accentColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: languageMeta.codeSurfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: languageMeta.accentColor.withValues(alpha: 0.2),
              ),
            ),
            child: SelectableText(
              state.latestSubmittedCode,
              style: const TextStyle(
                color: Color(0xFFE5E7EB),
                fontSize: 12,
                height: 1.6,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviousSubmissionHistoryCard extends StatelessWidget {
  final ReportSubmitState state;
  final bool isDarkMode;

  const _PreviousSubmissionHistoryCard({
    required this.state,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
        color: isDarkMode ? const Color(0xFF18181B) : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이전 채점 기록',
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode
                  ? const Color(0xFFF5F5F5)
                  : const Color(0xFF000000),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '현재 채점을 진행하지 않을 때, 이 문제에 대해 이전에 제출했던 결과를 시간순으로 보여줍니다.',
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode
                  ? const Color(0xFFD4D4D8)
                  : const Color(0xFF4B5563),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          if (state.previousSubmissions.isNotEmpty)
            ...state.previousSubmissions.asMap().entries.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(
                      bottom: entry.key == state.previousSubmissions.length - 1
                          ? 0
                          : 12,
                    ),
                    child: _SubmissionHistoryRow(
                      submission: entry.value,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _SubmissionHistoryRow extends StatelessWidget {
  final SubmissionResult submission;
  final bool isDarkMode;

  const _SubmissionHistoryRow({
    required this.submission,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final statusMeta = _testCaseStatusMeta(submission.status);
    final languageMeta = _languageEffectMeta(submission.language);
    final passedCount = submission.testCases
        .where((testCase) => (testCase.status ?? '').toUpperCase() == 'PASSED')
        .length;
    final totalCount = submission.testCases.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF27272A) : const Color(0xFFFCFCFD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: languageMeta.accentColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  languageMeta.icon,
                  color: languageMeta.accentColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusMeta.backgroundColor,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            statusMeta.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: statusMeta.textColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: languageMeta.accentColor
                                .withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: languageMeta.accentColor
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            _languageLabel(submission.language),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: languageMeta.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '제출: ${_formatDateTime(submission.createdAt)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode
                            ? const Color(0xFFE4E4E7)
                            : const Color(0xFF374151),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (submission.completedAt != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '완료: ${_formatDateTime(submission.completedAt)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode
                              ? const Color(0xFFA1A1AA)
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MetricChip(
                label: totalCount == 0
                    ? '테스트 정보 없음'
                    : '$passedCount / $totalCount 통과',
                icon: Icons.checklist_rounded,
                isDarkMode: isDarkMode,
              ),
              if (submission.completedAt != null &&
                  submission.createdAt != null)
                _MetricChip(
                  label: _durationLabel(
                    submission.createdAt!,
                    submission.completedAt!,
                  ),
                  icon: Icons.bolt_rounded,
                  isDarkMode: isDarkMode,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

_StatusMeta _statusMeta(SubmissionStatus status) {
  return switch (status) {
    SubmissionStatus.notSubmitted => const _StatusMeta(
        label: '미제출',
        backgroundColor: Color(0xFFF3F4F6),
        textColor: Color(0xFF4B5563),
      ),
    SubmissionStatus.submitting => const _StatusMeta(
        label: '제출 중',
        backgroundColor: Color(0xFFDBEAFE),
        textColor: Color(0xFF1D4ED8),
      ),
    SubmissionStatus.queued => const _StatusMeta(
        label: '대기 중',
        backgroundColor: Color(0xFFE0E7FF),
        textColor: Color(0xFF4338CA),
      ),
    SubmissionStatus.judging => const _StatusMeta(
        label: '채점 중',
        backgroundColor: Color(0xFFFEF3C7),
        textColor: Color(0xFF92400E),
      ),
    SubmissionStatus.accepted => const _StatusMeta(
        label: '통과',
        backgroundColor: Color(0xFFDCFCE7),
        textColor: Color(0xFF166534),
      ),
    SubmissionStatus.failed => const _StatusMeta(
        label: '보완 필요',
        backgroundColor: Color(0xFFFEE2E2),
        textColor: Color(0xFF991B1B),
      ),
    SubmissionStatus.error => const _StatusMeta(
        label: '오류',
        backgroundColor: Color(0xFFFEE2E2),
        textColor: Color(0xFF991B1B),
      ),
  };
}

class _StatusMeta {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const _StatusMeta({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
}

class _TestCaseStatusMeta {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  const _TestCaseStatusMeta({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });
}

class _LanguageEffectMeta {
  final String label;
  final Color accentColor;
  final Color lightSurfaceColor;
  final Color darkSurfaceColor;
  final Color codeSurfaceColor;
  final IconData icon;

  const _LanguageEffectMeta({
    required this.label,
    required this.accentColor,
    required this.lightSurfaceColor,
    required this.darkSurfaceColor,
    required this.codeSurfaceColor,
    required this.icon,
  });
}

_TestCaseStatusMeta _testCaseStatusMeta(String? status) {
  final normalized = status?.trim().toUpperCase() ?? 'UNKNOWN';
  return switch (normalized) {
    'PASSED' || 'ACCEPTED' => const _TestCaseStatusMeta(
        label: 'PASSED',
        backgroundColor: Color(0xFFDCFCE7),
        textColor: Color(0xFF166534),
        icon: Icons.check_rounded,
      ),
    'WRONG_ANSWER' => const _TestCaseStatusMeta(
        label: 'WRONG ANSWER',
        backgroundColor: Color(0xFFFEE2E2),
        textColor: Color(0xFF991B1B),
        icon: Icons.rule_folder_outlined,
      ),
    'TIME_LIMIT_EXCEEDED' => const _TestCaseStatusMeta(
        label: 'TIME LIMIT',
        backgroundColor: Color(0xFFFFEDD5),
        textColor: Color(0xFF9A3412),
        icon: Icons.timer_off_outlined,
      ),
    'MEMORY_LIMIT_EXCEEDED' => const _TestCaseStatusMeta(
        label: 'MEMORY LIMIT',
        backgroundColor: Color(0xFFFFEDD5),
        textColor: Color(0xFF9A3412),
        icon: Icons.sd_storage_outlined,
      ),
    'RUNTIME_ERROR' => const _TestCaseStatusMeta(
        label: 'RUNTIME ERROR',
        backgroundColor: Color(0xFFFCE7F3),
        textColor: Color(0xFF9D174D),
        icon: Icons.bolt_outlined,
      ),
    'COMPILE_ERROR' => const _TestCaseStatusMeta(
        label: 'COMPILE ERROR',
        backgroundColor: Color(0xFFF3E8FF),
        textColor: Color(0xFF7E22CE),
        icon: Icons.code_off_rounded,
      ),
    'RUNNING' || 'JUDGING' => const _TestCaseStatusMeta(
        label: 'RUNNING',
        backgroundColor: Color(0xFFFEF3C7),
        textColor: Color(0xFF92400E),
        icon: Icons.autorenew_rounded,
      ),
    'QUEUED' || 'PENDING' => const _TestCaseStatusMeta(
        label: 'QUEUED',
        backgroundColor: Color(0xFFE0E7FF),
        textColor: Color(0xFF4338CA),
        icon: Icons.schedule_rounded,
      ),
    'FAILED' => const _TestCaseStatusMeta(
        label: 'FAILED',
        backgroundColor: Color(0xFFFEE2E2),
        textColor: Color(0xFF991B1B),
        icon: Icons.close_rounded,
      ),
    _ => const _TestCaseStatusMeta(
        label: 'UNKNOWN',
        backgroundColor: Color(0xFFF3F4F6),
        textColor: Color(0xFF4B5563),
        icon: Icons.help_outline_rounded,
      ),
  };
}

List<String> _displayFeedbacks(List<String> feedbacks) {
  final testCasePattern = RegExp(r'^\d+번 테스트:');
  return feedbacks
      .where((feedback) => !testCasePattern.hasMatch(feedback.trim()))
      .toList(growable: false);
}

String _resolveHistoryProblemId({
  required Report report,
  required ReportSubmitState state,
}) {
  final historyProblemId = state.historyProblemId?.trim();
  if (historyProblemId != null && historyProblemId.isNotEmpty) {
    return historyProblemId;
  }

  final reportProblemId = report.problemId?.trim();
  if (reportProblemId != null && reportProblemId.isNotEmpty) {
    return reportProblemId;
  }

  return report.id;
}

_LanguageEffectMeta _languageEffectMeta(String? rawLanguage) {
  final normalized = rawLanguage?.trim().toUpperCase() ?? '';
  return switch (normalized) {
    'KOTLIN' => const _LanguageEffectMeta(
        label: 'Kotlin',
        accentColor: Color(0xFF7C3AED),
        lightSurfaceColor: Color(0xFFF5F3FF),
        darkSurfaceColor: Color(0xFF221533),
        codeSurfaceColor: Color(0xFF160F26),
        icon: Icons.auto_awesome_rounded,
      ),
    'DART' => const _LanguageEffectMeta(
        label: 'Dart',
        accentColor: Color(0xFF0891B2),
        lightSurfaceColor: Color(0xFFECFEFF),
        darkSurfaceColor: Color(0xFF10232B),
        codeSurfaceColor: Color(0xFF0B1720),
        icon: Icons.blur_on_rounded,
      ),
    'PYTHON' => const _LanguageEffectMeta(
        label: 'Python',
        accentColor: Color(0xFFCA8A04),
        lightSurfaceColor: Color(0xFFFEFCE8),
        darkSurfaceColor: Color(0xFF2A2411),
        codeSurfaceColor: Color(0xFF171409),
        icon: Icons.data_object_rounded,
      ),
    _ => const _LanguageEffectMeta(
        label: 'Code',
        accentColor: Color(0xFF64748B),
        lightSurfaceColor: Color(0xFFF8FAFC),
        darkSurfaceColor: Color(0xFF1F2937),
        codeSurfaceColor: Color(0xFF111827),
        icon: Icons.code_rounded,
      ),
  };
}

String _languageLabel(String? rawLanguage) {
  return _languageEffectMeta(rawLanguage).label;
}

String _durationLabel(DateTime createdAt, DateTime completedAt) {
  final duration = completedAt.difference(createdAt);
  final milliseconds = duration.inMilliseconds;
  if (milliseconds < 1000) {
    return '${milliseconds}ms';
  }
  final seconds = milliseconds / 1000;
  return '${seconds.toStringAsFixed(seconds >= 10 ? 1 : 2)}s';
}

String? _resultHeadline(SubmissionStatus status) {
  return switch (status) {
    SubmissionStatus.accepted => '정답입니다!',
    SubmissionStatus.failed || SubmissionStatus.error => '오답입니다.',
    SubmissionStatus.notSubmitted ||
    SubmissionStatus.submitting ||
    SubmissionStatus.queued ||
    SubmissionStatus.judging =>
      null,
  };
}

String _formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return '-';
  final y = dateTime.year.toString().padLeft(4, '0');
  final m = dateTime.month.toString().padLeft(2, '0');
  final d = dateTime.day.toString().padLeft(2, '0');
  final h = dateTime.hour.toString().padLeft(2, '0');
  final min = dateTime.minute.toString().padLeft(2, '0');
  return '$y-$m-$d $h:$min';
}
