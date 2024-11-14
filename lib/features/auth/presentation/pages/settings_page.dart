import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/core/router/app_router.dart';
import 'package:marketplace/core/shared/wrapper/scaffold_wrapper.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:marketplace/features/auth/presentation/manager/auth_riverpod.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ScaffoldWrapper(
        body: Column(
      children: [
        AppSpacing.setVerticalHeight(44),
        ClipRRect(
          borderRadius: BorderRadius.circular(100.radius),
          child: CachedNetworkImage(
            imageUrl: ref.watch(auth).userData?.avatar??'',
            placeholder: (context, url) => Icon(
              Icons.person_pin_circle_rounded,
              size: 180.height,
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.person_pin_circle_rounded,
              size: 180.height,
            ),
          ),
        ),
        AppSpacing.setVerticalHeight(20),
        Text(ref.watch(auth).userData?.name??'',
        style: context.textTheme.headlineMedium,),
        AppSpacing.setVerticalHeight(44),
        QuickActionCard(
          name: 'Edit Account',
          image: Icons.account_circle_rounded,
          onTap: () {
            context.router.push(const EditProfileRoute());
          },
        ),
        AppSpacing.setVerticalHeight(44),
        QuickActionCard(
          name: 'Sign-out',
          textColor: AppColors.red,
          image: Icons.logout,
          onTap: () {
            context.router.popUntilRouteWithName(LoginRoute.name);
          },
        )
      ],
    ));
  }
}

class QuickActionCard extends StatelessWidget {
  const QuickActionCard(
      {super.key,
      required this.name,
      required this.image,
      required this.onTap,
      this.fontSize,
      this.textColor,
      this.imageSize,
      this.padding});
  final String name;
  final double? fontSize;
  final double? imageSize;
  final double? padding;
  final Color? textColor;
  final IconData image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(padding ?? 16),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: AppColors.lightBlack.withOpacity(0.5),
              )
            ]),
        child: Row(
          children: [
            Icon(
              image,
              color: AppColors.grey1,
            ),
            AppSpacing.setHorizontalHeight(16),
            Text(
              name,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: textColor ?? AppColors.yellow,
                fontSize: fontSize ?? 14,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.grey1,
            )
          ],
        ),
      ),
    );
  }
}
