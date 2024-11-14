import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';

enum IconType { error, info, check, none }

class IconRow extends StatelessWidget {
  const IconRow({
    super.key,
    this.icon,
    required this.text,
    this.color,
    this.onTap,
    this.fontSize,
    this.iconType = IconType.none,
    this.passed = false,
  });

  final Widget? icon;
  final String text;
  final Color? color;
  final bool? passed;
  final double? fontSize;
  final VoidCallback? onTap;
  final IconType? iconType;

  @override
  Widget build(BuildContext context) => CupertinoButton(
        onPressed: () {
          onTap?.call();
          HapticFeedback.selectionClick();
        },
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            setIcon(),
            AppSpacing.setHorizontalHeight(7),
            Text(
              text,
              style: context.textTheme.bodyLarge!.copyWith(
                color:passed! ?  AppColors.success :color ??
                    AppColors.grey1,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      );


  Widget setIcon() {
    if (icon != null) {
      return icon!;
    } else if (iconType == IconType.info) {
      return const Icon(
        Icons.info_outline,
        color: AppColors.grey1,
      );
    } else if (iconType == IconType.check) {
      return Icon(Icons.check_circle_outline,
      color: passed! ? AppColors.success:
      AppColors.grey1);
    } else {
      return const SizedBox();
    }
  }
}
