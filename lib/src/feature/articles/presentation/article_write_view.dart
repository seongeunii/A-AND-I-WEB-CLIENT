import 'dart:async';

import 'package:a_and_i_report_web_server/src/core/auth/role_policy.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_state.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/ui/viewModels/article_write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/presentation/widgets/article_editor_markdown_actions.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/presentation/widgets/article_editor_panel.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/presentation/widgets/article_preview_panel.dart';
import 'package:image_picker/image_picker.dart';

const String articleWriteDefaultTitle = '';
const String articleWriteDefaultMarkdown = '';

class ArticleWriteView extends ConsumerStatefulWidget {
  const ArticleWriteView({super.key});

  @override
  ConsumerState<ArticleWriteView> createState() => ArticleWriteViewState();
}

class ArticleWriteViewState extends ConsumerState<ArticleWriteView> {
  static const Duration _autoSaveInterval = Duration(minutes: 1);

  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late final FocusNode contentFocusNode;
  late final UndoHistoryController contentUndoController;
  Timer? _autoSaveTimer;
  bool _isAutoSaving = false;

  @override
  void initState() {
    super.initState();
    final composeState = ref.read(articleWriteViewModelProvider);
    final initialTitle = composeState.title.isEmpty
        ? articleWriteDefaultTitle
        : composeState.title;
    final initialMarkdown = composeState.contentMarkdown.isEmpty
        ? articleWriteDefaultMarkdown
        : composeState.contentMarkdown;
    titleController = TextEditingController(text: initialTitle);
    contentController = TextEditingController(text: initialMarkdown);
    contentFocusNode = FocusNode();
    contentUndoController = UndoHistoryController();
    _startAutoSaveTimer();
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    titleController.dispose();
    contentController.dispose();
    contentFocusNode.dispose();
    contentUndoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    if (userState.status == UserStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final canManageArticles = canManageArticlesWithRole(userState.resolvedRole);
    if (!canManageArticles) {
      return const _ArticleWritePermissionDeniedView();
    }

    final composeState = ref.watch(articleWriteViewModelProvider);
    final isEditingPublished = composeState.postId.trim().isNotEmpty &&
        composeState.editingPostStatus.trim().toLowerCase() == 'published';
    final width = MediaQuery.of(context).size.width;
    final split = width >= 1100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.keyZ, control: true):
                ArticleUndoIntent(),
            SingleActivator(LogicalKeyboardKey.keyZ, meta: true):
                ArticleUndoIntent(),
            SingleActivator(LogicalKeyboardKey.keyZ,
                control: true, shift: true): ArticleRedoIntent(),
            SingleActivator(LogicalKeyboardKey.keyZ, meta: true, shift: true):
                ArticleRedoIntent(),
            SingleActivator(LogicalKeyboardKey.keyS, control: true):
                ArticleSaveDraftIntent(),
            SingleActivator(LogicalKeyboardKey.keyS, meta: true):
                ArticleSaveDraftIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              ArticleUndoIntent: CallbackAction<ArticleUndoIntent>(
                onInvoke: (intent) {
                  if (contentFocusNode.hasFocus &&
                      contentUndoController.value.canUndo) {
                    contentUndoController.undo();
                  }
                  return null;
                },
              ),
              ArticleRedoIntent: CallbackAction<ArticleRedoIntent>(
                onInvoke: (intent) {
                  if (contentFocusNode.hasFocus &&
                      contentUndoController.value.canRedo) {
                    contentUndoController.redo();
                  }
                  return null;
                },
              ),
              ArticleSaveDraftIntent: CallbackAction<ArticleSaveDraftIntent>(
                onInvoke: (intent) {
                  unawaited(_onShortcutSaveDraft(context));
                  return null;
                },
              ),
            },
            child: Stack(
              children: [
                ListenableBuilder(
                  listenable: Listenable.merge([
                    titleController,
                    contentController,
                  ]),
                  builder: (context, child) {
                    if (split) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Color(0xFFE5E7EB)),
                                ),
                              ),
                              child: ArticleEditorPanel(
                                titleController: titleController,
                                contentController: contentController,
                                contentFocusNode: contentFocusNode,
                                contentUndoController: contentUndoController,
                                onExit: () => context.go('/articles'),
                                onBold: onTapBold,
                                onItalic: onTapItalic,
                                onStrikethrough: onTapStrikethrough,
                                onQuote: onTapQuote,
                                onCodeBlock: onTapCodeBlock,
                                onImage: () => onTapImage(context),
                                onLink: onTapLink,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ArticlePreviewPanel(
                              title: titleController.text.trim(),
                              markdown: contentController.text,
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ArticleEditorPanel(
                            titleController: titleController,
                            contentController: contentController,
                            contentFocusNode: contentFocusNode,
                            contentUndoController: contentUndoController,
                            onExit: () => context.go('/articles'),
                            onBold: onTapBold,
                            onItalic: onTapItalic,
                            onStrikethrough: onTapStrikethrough,
                            onQuote: onTapQuote,
                            onCodeBlock: onTapCodeBlock,
                            onImage: () => onTapImage(context),
                            onLink: onTapLink,
                          ),
                        ),
                        const Divider(height: 1, color: Color(0xFFE5E7EB)),
                        Expanded(
                          child: ArticlePreviewPanel(
                            title: titleController.text.trim(),
                            markdown: contentController.text,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  right: split ? 32 : 16,
                  bottom: split ? 24 : 16,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: composeState.isSubmitting ||
                                composeState.isUploadingImage
                            ? null
                            : () => onTapSaveDraft(context),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF3F4F6),
                          foregroundColor: const Color(0xFF374151),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isEditingPublished ? '수정 저장' : '임시저장',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(
                        onPressed: composeState.isSubmitting ||
                                composeState.isUploadingImage
                            ? null
                            : () => onTapGoConfirm(context),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF111827),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isEditingPublished ? '수정 완료' : '출간하기',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                if (composeState.isUploadingImage || composeState.isSubmitting)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapBold() {
    ArticleEditorMarkdownActions.applyBold(contentController, contentFocusNode);
  }

  void onTapItalic() {
    ArticleEditorMarkdownActions.applyItalic(
        contentController, contentFocusNode);
  }

  void onTapStrikethrough() {
    ArticleEditorMarkdownActions.applyStrikethrough(
      contentController,
      contentFocusNode,
    );
  }

  void onTapQuote() {
    ArticleEditorMarkdownActions.applyQuote(
        contentController, contentFocusNode);
  }

  void onTapCodeBlock() {
    ArticleEditorMarkdownActions.applyCodeBlock(
      contentController,
      contentFocusNode,
    );
  }

  Future<void> onTapImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }

    final bytes = await pickedFile.readAsBytes();
    if (!context.mounted) {
      return;
    }

    final uploadedImageUrl =
        await ref.read(articleWriteViewModelProvider.notifier).uploadImage(
              fileName: _resolveFileName(pickedFile, bytes),
              bytes: bytes,
            );

    if (!context.mounted) {
      return;
    }

    if (uploadedImageUrl == null || uploadedImageUrl.isEmpty) {
      final errorMsg = ref.read(articleWriteViewModelProvider).errorMsg;
      _showMessage(
        context,
        errorMsg.isEmpty ? '이미지 업로드에 실패했습니다.' : errorMsg,
      );
      return;
    }

    ArticleEditorMarkdownActions.applyUploadedImage(
      contentController,
      contentFocusNode,
      imageUrl: uploadedImageUrl,
      altText: '이미지',
    );
    _showMessage(context, '이미지 업로드 후 본문에 삽입했습니다.');
  }

  void onTapLink() {
    ArticleEditorMarkdownActions.applyLink(contentController, contentFocusNode);
  }

  Future<void> onTapSaveDraft(BuildContext context) async {
    final success =
        await ref.read(articleWriteViewModelProvider.notifier).saveDraft(
              title: titleController.text,
              contentMarkdown: contentController.text,
            );
    if (!context.mounted) {
      return;
    }

    final composeState = ref.read(articleWriteViewModelProvider);
    if (success) {
      _showMessage(context, composeState.successMsg);
      return;
    }

    _showMessage(
      context,
      composeState.errorMsg.isEmpty ? '임시저장에 실패했습니다.' : composeState.errorMsg,
    );
  }

  Future<void> _onShortcutSaveDraft(BuildContext context) async {
    final composeState = ref.read(articleWriteViewModelProvider);
    if (composeState.isSubmitting || composeState.isUploadingImage) {
      return;
    }

    await onTapSaveDraft(context);
  }

  void onTapGoConfirm(BuildContext context) {
    _syncDraft();
    context.go('/articles/confirm');
  }

  void _syncDraft() {
    ref.read(articleWriteViewModelProvider.notifier).syncDraft(
          title: titleController.text,
          contentMarkdown: contentController.text,
        );
  }

  void _startAutoSaveTimer() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(_autoSaveInterval, (_) {
      unawaited(_triggerAutoSave());
    });
  }

  Future<void> _triggerAutoSave() async {
    if (!mounted || _isAutoSaving) {
      return;
    }

    final userState = ref.read(userViewModelProvider);
    if (userState.status != UserStatus.authenticated ||
        !canManageArticlesWithRole(userState.resolvedRole)) {
      return;
    }

    _isAutoSaving = true;
    try {
      await ref.read(articleWriteViewModelProvider.notifier).autoSaveDraft(
            title: titleController.text,
            contentMarkdown: contentController.text,
          );
    } finally {
      _isAutoSaving = false;
    }
  }

  String _resolveFileName(XFile file, Uint8List bytes) {
    if (file.name.isNotEmpty) {
      return file.name;
    }
    return 'image_${DateTime.now().millisecondsSinceEpoch}_${bytes.length}.png';
  }

  void _showMessage(BuildContext context, String msg) {
    if (msg.trim().isEmpty) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}

class ArticleUndoIntent extends Intent {
  const ArticleUndoIntent();
}

class ArticleRedoIntent extends Intent {
  const ArticleRedoIntent();
}

class ArticleSaveDraftIntent extends Intent {
  const ArticleSaveDraftIntent();
}

class _ArticleWritePermissionDeniedView extends StatelessWidget {
  const _ArticleWritePermissionDeniedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ORGANIZER 이상 권한이 필요합니다.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.go('/articles'),
                child: const Text('목록으로 이동'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
