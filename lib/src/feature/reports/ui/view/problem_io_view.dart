import 'package:a_and_i_report_web_server/src/core/theme/code_font.dart';
import 'package:a_and_i_report_web_server/src/core/utils/app_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProblemIOView extends StatelessWidget {
  final List<(String, String)> contents;
  final bool isDarkMode;
  const ProblemIOView({
    super.key,
    required this.contents,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contents.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final input = entry.value.$1;
        final output = entry.value.$2;
        return _IOExample(
          index: index,
          input: input,
          output: output,
          isDarkMode: isDarkMode,
        );
      }).toList(),
    );
  }
}

class _IOExample extends StatelessWidget {
  final int index;
  final String input;
  final String output;
  final bool isDarkMode;

  const _IOExample({
    required this.index,
    required this.input,
    required this.output,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '예제 입력 $index',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? const Color(0xFFA1A1AA)
                      : const Color(0xFF6B7280),
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: input));
                  showGlobalSnackBar('예제 입력 $index를 복사했습니다.');
                },
                borderRadius: BorderRadius.circular(6),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.copy, size: 14, color: Color(0xFF6B7280)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFF27272A)
                  : const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDarkMode
                    ? const Color(0xFF3F3F46)
                    : const Color(0xFFF3F4F6),
              ),
            ),
            child: SelectableText(
              input,
              style: vscodeCodeTextStyle(TextStyle(
                fontSize: 13,
                color: isDarkMode
                    ? const Color(0xFFE5E7EB)
                    : const Color(0xFF000000),
                height: 1.6,
              )),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '예제 출력 $index',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDarkMode
                  ? const Color(0xFFA1A1AA)
                  : const Color(0xFF6B7280),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFF3F3F46)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              output,
              style: vscodeCodeTextStyle(TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? const Color(0xFFF5F5F5)
                    : const Color(0xFF000000),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
