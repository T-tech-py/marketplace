import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/core/l10n/l10n.dart';
import 'package:marketplace/core/shared/widget/app_button.dart';
import 'package:marketplace/core/shared/widget/app_text_field.dart';
import 'package:marketplace/core/shared/wrapper/scaffold_wrapper.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';
import 'package:marketplace/features/auth/presentation/manager/auth_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWrapper(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BackButton(),
        AppSpacing.setVerticalHeight(30),
        Expanded(child: _Body(ref: ref,)),
      ],
    ));
  }
}

class _Body extends HookWidget {
  const _Body({ required this.ref});
final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    final name = useTextEditingController(text: ref.read(auth).userData?.name);
    final role = useTextEditingController(text: ref.read(auth).userData?.role);
    final email = useTextEditingController(text: ref.read(auth).userData?.email);
    final password = useTextEditingController(text: ref.read(auth).userData?.password);
    final avatar = useTextEditingController(text: ref.read(auth).userData?.avatar);
    final id = useTextEditingController(text: ref.read(auth).userData?.id.toString());
    return SingleChildScrollView(
      child: Skeletonizer(
        enabled: ref.watch(auth).isBusy,
        child: Column(
          children: [
            AppTextField(
              label: '*${localizations.email}',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enable: false,
              controller: email,
            ),
            AppSpacing.setVerticalHeight(16),
            AppTextField(
              label: '*${localizations.firstName} & ${localizations.lastName}',
              textInputAction: TextInputAction.next,
              controller: name,
            ),
            AppSpacing.setVerticalHeight(16),
            AppTextField(
              label: '*${localizations.role}',
              textInputAction: TextInputAction.next,
              enable: false,
              controller: role,
            ),
            AppSpacing.setVerticalHeight(16),
            AppTextField(
              label: '*${localizations.password} ',
              obscureText: true,
              enable: false,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.go,
              controller: password,
            ),
            AppSpacing.setVerticalHeight(30),
            AppTextField(
              label: '*${localizations.avatar} ',
              enable: false,
              textInputAction: TextInputAction.next,
              controller: avatar,
            ),
            AppSpacing.setVerticalHeight(70),
            AppButton(text: localizations.continueText,
                onTap: (){
                  ref.watch(auth).editProfile(UserData(
                      name: name.text,
                      email: email.text,
                      password: password.text,
                      role: role.text,
                      avatar: avatar.text,
                      id: int.parse(id.text)), context);
                }),
            AppSpacing.setVerticalHeight(30),
          ],
        ),
      ),
    );
  }
}
