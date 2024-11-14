import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/core/l10n/l10n.dart';
import 'package:marketplace/core/router/app_router.dart';
import 'package:marketplace/core/shared/widget/app_button.dart';
import 'package:marketplace/core/shared/widget/app_text_field.dart';
import 'package:marketplace/core/shared/widget/border_button.dart';
import 'package:marketplace/core/shared/wrapper/scaffold_wrapper.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_request.dart';
import 'package:marketplace/features/auth/presentation/manager/auth_riverpod.dart';
import 'package:marketplace/features/auth/presentation/widgets/logo.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ScaffoldWrapper(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSpacing.setVerticalHeight(16),
            const Logo(),
            AppSpacing.setVerticalHeight(48),
            _SignIn(ref),
          ],
        ),
      );
}

class _SignIn extends HookWidget {
  const _SignIn(this.ref);
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    final emailController =
        useTextEditingController(text: 'john@mail.com');
    final passwordController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return Form(
      key: formKey,
      child: Skeletonizer(
        enabled: ref.watch(auth).isBusy,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSpacing.setVerticalHeight(77),
            Text(
              localizations.signIn,
              style: context.textTheme.headlineLarge!.copyWith(
                fontSize: 18.fontSize,
              ),
            ),
            AppSpacing.setVerticalHeight(8),
            Text(
              localizations.signInSub,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: 14.fontSize,
                fontWeight: FontWeight.w200,
              ),
            ),
            AppSpacing.setVerticalHeight(24),
            AppTextField(
              label: '*${localizations.email}',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              validator: (email) {
                // if (context.validateEmailAddress(email ?? '') != null) {
                //   return 'invalid email';
                // }
                // return null;
              },
            ),
            AppSpacing.setVerticalHeight(14),
            AppTextField(
              label: localizations.password,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) {
                if (formKey.currentState?.validate() ?? false) {}
              },
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid password';
                }
                return null;
              },
            ),
            AppSpacing.setVerticalHeight(24),
            AppButton(
              text: localizations.signIn,
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  ref.watch(auth).login(LoginRequest(
                      email: emailController.text,
                      password: passwordController.text),context);
                }
              },
            ),
            AppSpacing.setVerticalHeight(24),
            BorderButton(
             text:  localizations.createAccount,
              width: double.infinity,
              height: 45.height,
              onTap: () {
               context.router.push(const CreateAccountRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
