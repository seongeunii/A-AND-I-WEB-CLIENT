import 'package:flutter/material.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';

class ArticleEditorPanel extends StatelessWidget {
  const ArticleEditorPanel({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.contentFocusNode,
    required this.contentUndoController,
    required this.onExit,
    required this.onBold,
    required this.onItalic,
    required this.onStrikethrough,
    required this.onQuote,
    required this.onCodeBlock,
    required this.onImage,
    required this.onLink,
    this.markdownAreaKey,
    this.isMarkdownDragOver = false,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final FocusNode contentFocusNode;
  final UndoHistoryController contentUndoController;
  final VoidCallback onExit;
  final VoidCallback onBold;
  final VoidCallback onItalic;
  final VoidCallback onStrikethrough;
  final VoidCallback onQuote;
  final VoidCallback onCodeBlock;
  final VoidCallback onImage;
  final VoidCallback onLink;
  final Key? markdownAreaKey;
  final bool isMarkdownDragOver;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final showTopExit = isMobile || isTablet;
    final horizontalPadding = isMobile ? 20.0 : (width < 1200 ? 28.0 : 40.0);
    final verticalPadding = isMobile ? 20.0 : (width < 1200 ? 28.0 : 38.0);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showTopExit)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextButton.icon(
                          onPressed: onExit,
                          style: TextButton.styleFrom(
                            foregroundColor: HomeTheme.textMuted,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: const Icon(Icons.arrow_back, size: 19),
                          label: const Text(
                            '나가기',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  TextField(
                    controller: titleController,
                    style: TextStyle(
                      color: HomeTheme.textMain,
                      fontSize: isMobile ? 30 : 42,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      letterSpacing: -1.2,
                    ),
                    decoration: InputDecoration(
                      hintText: '제목',
                      hintStyle: TextStyle(
                        color: const Color(0xFFD1D5DB),
                        fontSize: isMobile ? 30 : 42,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: -1.2,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.only(bottom: 14),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFF3F4F6)),
                      ),
                    ),
                    child: Row(
                      children: [
                        ArticleToolbarIcon(
                          icon: Icons.format_bold,
                          onTap: onBold,
                        ),
                        SizedBox(width: 8),
                        ArticleToolbarIcon(
                          icon: Icons.format_italic,
                          onTap: onItalic,
                        ),
                        SizedBox(width: 8),
                        ArticleToolbarIcon(
                          icon: Icons.format_strikethrough,
                          onTap: onStrikethrough,
                        ),
                        SizedBox(width: 12),
                        const SizedBox(
                          width: 1,
                          height: 16,
                          child: ColoredBox(color: Color(0xFFE5E7EB)),
                        ),
                        SizedBox(width: 12),
                        ArticleToolbarIcon(
                          icon: Icons.format_quote,
                          onTap: onQuote,
                        ),
                        SizedBox(width: 8),
                        ArticleToolbarIcon(
                          icon: Icons.code,
                          onTap: onCodeBlock,
                        ),
                        SizedBox(width: 8),
                        ArticleToolbarIcon(
                          icon: Icons.image_outlined,
                          onTap: onImage,
                        ),
                        SizedBox(width: 8),
                        ArticleToolbarIcon(
                          icon: Icons.link,
                          onTap: onLink,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    decoration: BoxDecoration(
                      color: isMarkdownDragOver
                          ? const Color(0xFFF9FAFB)
                          : Colors.transparent,
                      border: Border.all(
                        color: isMarkdownDragOver
                            ? const Color(0xFF9CA3AF)
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ConstrainedBox(
                      key: markdownAreaKey,
                      constraints: BoxConstraints(
                        minHeight: isMobile ? 300 : 520,
                      ),
                      child: TextField(
                        controller: contentController,
                        focusNode: contentFocusNode,
                        undoController: contentUndoController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 16,
                          height: 1.7,
                          fontFamily: 'monospace',
                        ),
                        decoration: const InputDecoration(
                          hintText: '당신의 이야기를 적어주세요',
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!showTopExit)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 14,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF3F4F6)),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: onExit,
                  style: TextButton.styleFrom(
                    foregroundColor: HomeTheme.textMuted,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(Icons.arrow_back, size: 19),
                  label: const Text(
                    '나가기',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ArticleToolbarIcon extends StatelessWidget {
  const ArticleToolbarIcon({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 21,
          color: const Color(0xFF9CA3AF),
        ),
      ),
    );
  }
}
