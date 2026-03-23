import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/login_ui_event.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/login_ui_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginTextFieldView extends HookConsumerWidget {
  const LoginTextFieldView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUiViewModel = ref.read(loginUiViewModelProvider.notifier);
    final accountController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPasswordVisible = useState<bool>(false);
    return Column(
      children: [
        TextField(
          controller: accountController,
          cursorColor: HomeTheme.primary,
          style: const TextStyle(
            color: HomeTheme.textMain,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.02),
            prefixIcon: Icon(
              Icons.account_circle_outlined,
              color: HomeTheme.textMuted,
            ),
            hintText: "계정",
            hintStyle: const TextStyle(
              color: HomeTheme.textMuted,
              fontWeight: FontWeight.w500,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1.4,
                color: HomeTheme.primary.withValues(alpha: 0.65),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.black.withValues(alpha: 0.08),
              ),
            ),
          ),
          onChanged: (userId) {
            final event = UserAccountInput(userId: userId);
            loginUiViewModel.onEvent(event);
          },
        ),
        const SizedBox(height: 12),
        TextField(
          controller: passwordController,
          cursorColor: HomeTheme.primary,
          style: const TextStyle(
            color: HomeTheme.textMain,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          obscureText: !isPasswordVisible.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.02),
            prefixIcon: Icon(
              Icons.lock,
              color: HomeTheme.textMuted,
            ),
            hintText: "비밀번호",
            hintStyle: const TextStyle(
              color: HomeTheme.textMuted,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                isPasswordVisible.value = !isPasswordVisible.value;
              },
              icon: Icon(
                isPasswordVisible.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: HomeTheme.textMuted,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1.4,
                color: HomeTheme.primary.withValues(alpha: 0.65),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.black.withValues(alpha: 0.08),
              ),
            ),
          ),
          onChanged: (password) {
            final event = UserPasswordInput(password: password);
            loginUiViewModel.onEvent(event);
          },
        ),
      ],
    );
  }
}
