import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/core/l10n/l10n.dart';
import 'package:marketplace/core/shared/widget/app_button.dart';
import 'package:marketplace/core/shared/widget/app_text_field.dart';
import 'package:marketplace/core/shared/wrapper/scaffold_wrapper.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:marketplace/features/auth/domain/entities/signup/sign_up_request.dart';
import 'package:marketplace/features/auth/presentation/manager/auth_riverpod.dart';
import 'package:marketplace/features/auth/presentation/widgets/logo.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CreateAccountPage extends ConsumerWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWrapper(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Logo(
          goBack: true,
        ),
        AppSpacing.setVerticalHeight(20),
        Expanded(child: _Body(ref)),
      ],
    ));
  }
}

class _Body extends HookWidget {
  const _Body(this.ref);
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    final appString = context.l10n;
    final isPasswordValid = useState(false);
    final passwordController = useTextEditingController();
    final firstName = useTextEditingController();
    final lastName = useTextEditingController();
    final emailController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final hasUppercase = useState(false);
    final hasLowercase = useState(false);
    final hasNumber = useState(false);
    final hasSpecialChar = useState(false);
    final isLengthValid = useState(false);

    return Skeletonizer(
      enabled: ref.watch(auth).isBusy,
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            Text(
              appString.signIn,
              style: context.textTheme.headlineLarge!.copyWith(
                fontSize: 18.fontSize,
              ),
            ),
            AppSpacing.setVerticalHeight(16),
            AppTextField(
              label: '*${appString.email}',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              validator: (email) {
                // if (context.validateEmailAddress(email ?? '') != null) {
                //   return localizations.invalidEmailAddress;
                // }
                // return null;
              },
            ),
            AppSpacing.setVerticalHeight(16),
            AppTextField(
              label: '*${appString.firstName}',
              textInputAction: TextInputAction.next,
              controller: firstName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appString.pleaseEnterAValidFirstName;
                }
                return null;
              },
            ),
            AppSpacing.setVerticalHeight(16),
            AppTextField(
              label: '*${appString.lastName}',
              textInputAction: TextInputAction.next,
              controller: lastName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appString.pleaseEnterAValidLastName;
                }
                return null;
              },
            ),
            AppSpacing.setVerticalHeight(16),
            AppTextField(
              label: appString.password,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.length < 3) {
                  return appString.pleaseEnterAValidPassword;
                }
                return null;
              },
            ),
            Text(
              appString.yourPasswordMustContainAtLeast,
              style: context.textTheme.bodyLarge!.copyWith(
                color: AppColors.grey1,
              ),
            ),
            AppSpacing.setVerticalHeight(36),
            AppButton(
              text: appString.continueText,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  ref.watch(auth).signUp(
                      SignUpRequest(
                          name: '${firstName.text} ${lastName.text}',
                          email: emailController.text,
                          password: passwordController.text,
                      avatar: "https://picsum.photos/800",),
                      context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }


}
