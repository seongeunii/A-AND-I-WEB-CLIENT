import 'dart:async';

import 'package:a_and_i_report_web_server/src/core/theme/code_font.dart';
import 'package:a_and_i_report_web_server/src/core/widgets/bottom_logo.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/utils/report_deadline.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/problem_bullet_list.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/problem_io_view.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/problem_nav_tabs.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/problem_section_header.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/report_submit_result_view.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/source_code_submit_view.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/viewModel/report_submit_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/widgets/problem_level_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProblemDetailView extends HookConsumerWidget {
  final Report report;
  final DateTime? endAt;
  final bool isDarkMode;
  const ProblemDetailView({
    super.key,
    required this.report,
    this.endAt,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    final currentTime = useState(DateTime.now().toUtc());
    final historyProblemId = report.problemId?.trim().isNotEmpty == true
        ? report.problemId!.trim()
        : report.id.trim();
    final isSubmissionClosed = isReportDeadlineClosed(
      endAt,
      now: currentTime.value,
    );

    useEffect(() {
      if (endAt == null ||
          isReportDeadlineClosed(endAt, now: currentTime.value)) {
        return null;
      }

      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        final now = DateTime.now().toUtc();
        currentTime.value = now;
        if (isReportDeadlineClosed(endAt, now: now)) {
          timer!.cancel();
        }
      });

      return timer.cancel;
    }, [endAt]);

    void selectTab(int nextTab) {
      if (nextTab == 1 && isSubmissionClosed) {
        return;
      }
      selectedTab.value = nextTab;
      if (nextTab == 2 && historyProblemId.isNotEmpty) {
        unawaited(
          ref
              .read(reportSubmitViewModelProvider(report).notifier)
              .loadSubmissionHistory(
                problemId: historyProblemId,
                forceRefresh: true,
              ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeaderCard(
          report: report,
          selectedTab: selectedTab.value,
          onSelectTab: selectTab,
          endAt: endAt,
          currentTime: currentTime.value,
          isSubmissionClosed: isSubmissionClosed,
          isDarkMode: isDarkMode,
        ),
        _ContentCard(
          report: report,
          selectedTab: selectedTab.value,
          isSubmissionClosed: isSubmissionClosed,
          isDarkMode: isDarkMode,
          onMoveToResultTab: () => selectTab(2),
        ),
        const SizedBox(height: 64),
        const BottomLogo(),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final Report report;
  final int selectedTab;
  final ValueChanged<int> onSelectTab;
  final DateTime? endAt;
  final DateTime currentTime;
  final bool isSubmissionClosed;
  final bool isDarkMode;

  const _HeaderCard({
    required this.report,
    required this.selectedTab,
    required this.onSelectTab,
    this.endAt,
    required this.currentTime,
    required this.isSubmissionClosed,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 720;
        final isNarrow = constraints.maxWidth < 420;
        final horizontalPadding = isCompact ? 20.0 : 48.0;
        final topPadding = isCompact ? 24.0 : 40.0;
        final titleFontSize = isNarrow
            ? 22.0
            : isCompact
                ? 24.0
                : 28.0;

        return Container(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            topPadding,
            horizontalPadding,
            0,
          ),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF18181B) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            border: Border(
              top: BorderSide(
                  color: isDarkMode
                      ? const Color(0xFF27272A)
                      : const Color(0xFFE5E7EB)),
              left: BorderSide(
                  color: isDarkMode
                      ? const Color(0xFF27272A)
                      : const Color(0xFFE5E7EB)),
              right: BorderSide(
                  color: isDarkMode
                      ? const Color(0xFF27272A)
                      : const Color(0xFFE5E7EB)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isCompact) ...[
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth - horizontalPadding * 2,
                      ),
                      child: Text(
                        report.title,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xFF000000),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    ProblemLevelBadge(level: report.level),
                  ],
                ),
                if (endAt != null) ...[
                  const SizedBox(height: 12),
                  _DeadlineTimer(
                    endAt: endAt!,
                    currentTime: currentTime,
                    isDarkMode: isDarkMode,
                  ),
                ],
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              report.title,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF000000),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ProblemLevelBadge(level: report.level),
                        ],
                      ),
                    ),
                    if (endAt != null) ...[
                      const SizedBox(width: 20),
                      _DeadlineTimer(
                        endAt: endAt!,
                        currentTime: currentTime,
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ],
                ),
              SizedBox(height: isCompact ? 24 : 32),
              ProblemNavTabs(
                selectedTab: selectedTab,
                onSelectTab: onSelectTab,
                isSubmitDisabled: isSubmissionClosed,
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ContentCard extends StatelessWidget {
  final Report report;
  final int selectedTab;
  final bool isSubmissionClosed;
  final bool isDarkMode;
  final VoidCallback onMoveToResultTab;

  const _ContentCard({
    required this.report,
    required this.selectedTab,
    required this.isSubmissionClosed,
    required this.isDarkMode,
    required this.onMoveToResultTab,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentPadding = constraints.maxWidth < 720 ? 20.0 : 48.0;

        return Container(
          padding: EdgeInsets.all(contentPadding),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF18181B) : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(
              color: isDarkMode
                  ? const Color(0xFF27272A)
                  : const Color(0xFFE5E7EB),
            ),
          ),
          child: switch (selectedTab) {
            0 => _ProblemTab(report: report, isDarkMode: isDarkMode),
            1 => SourceCodeSubmitView(
                report: report,
                isSubmissionClosed: isSubmissionClosed,
                isDarkMode: isDarkMode,
                onSubmitSuccess: onMoveToResultTab,
              ),
            2 => ReportSubmitResultView(report: report, isDarkMode: isDarkMode),
            _ => _ComingSoon(isDarkMode: isDarkMode),
          },
        );
      },
    );
  }
}

class _ProblemTab extends StatelessWidget {
  final Report report;
  final bool isDarkMode;
  const _ProblemTab({required this.report, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProblemSectionHeader(label: '문제 설명', isDarkMode: isDarkMode),
        const SizedBox(height: 24),
        Text(
          report.content,
          style: TextStyle(
            fontSize: 14,
            color:
                isDarkMode ? const Color(0xFFE5E7EB) : const Color(0xFF000000),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 48),
        ProblemSectionHeader(label: '문제 요구 사항', isDarkMode: isDarkMode),
        const SizedBox(height: 24),
        ProblemBulletList(
          items: report.requirement.map((r) => r.content).toList(),
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 48),
        ProblemSectionHeader(label: '학습 정리 목표', isDarkMode: isDarkMode),
        const SizedBox(height: 24),
        ProblemBulletList(
          items: report.objects.map((o) => o.content).toList(),
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 48),
        ProblemSectionHeader(label: '예제 입출력', isDarkMode: isDarkMode),
        const SizedBox(height: 32),
        ProblemIOView(
          contents:
              report.exampleIo.map((io) => (io.input, io.output)).toList(),
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }
}

class _ComingSoon extends StatelessWidget {
  final bool isDarkMode;
  const _ComingSoon({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Text(
          '준비 중입니다.',
          style: TextStyle(
            fontSize: 14,
            color:
                isDarkMode ? const Color(0xFFE5E7EB) : const Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}

class _DeadlineTimer extends StatelessWidget {
  final DateTime endAt;
  final DateTime currentTime;
  final bool isDarkMode;
  const _DeadlineTimer({
    required this.endAt,
    required this.currentTime,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = isReportDeadlineClosed(endAt, now: currentTime);
    final remaining = remainingUntilReportDeadline(endAt, now: currentTime);

    if (isDone) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 15,
            color:
                isDarkMode ? const Color(0xFFA1A1AA) : const Color(0xFF9CA3AF),
          ),
          const SizedBox(width: 5),
          Text(
            '종료됨',
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode
                  ? const Color(0xFFA1A1AA)
                  : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      );
    }

    final h = remaining.inHours.toString().padLeft(2, '0');
    final m = (remaining.inMinutes % 60).toString().padLeft(2, '0');
    final s = (remaining.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.schedule,
          size: 15,
          color: isDarkMode ? const Color(0xFFA1A1AA) : const Color(0xFF6B7280),
        ),
        const SizedBox(width: 5),
        Text.rich(
          TextSpan(
            text: '마감까지 ',
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode
                  ? const Color(0xFFA1A1AA)
                  : const Color(0xFF6B7280),
            ),
            children: [
              TextSpan(
                text: '$h:$m:$s',
                style: vscodeCodeTextStyle(TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? const Color(0xFFE5E7EB)
                      : const Color(0xFF000000),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
