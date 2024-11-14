import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/app_theme.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


extension ThemeExtension on BuildContext{

  ThemeData get theme => AppTheme.darkTheme;

  TextTheme get textTheme => theme.textTheme;
}

extension NumberExtension on num{

  double get fontSize => (this).sp;

  double get height => (this).h;

  double get width => (this).w;

  double get radius => (this).r;

}

extension BuildContextExtension on BuildContext {
  void showSnackBar({
    required String message,
    SnackBarType type = SnackBarType.success,
  }) =>
      showTopSnackBar(
        Overlay.of(this),
        switch (type) {
          SnackBarType.error => CustomSnackBar.error(
            message: message,
            backgroundColor: AppColors.red,
            textStyle: TextStyle(
              fontSize: 12.fontSize,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
            borderRadius: BorderRadius.circular(8.radius),
          ),
          SnackBarType.success => CustomSnackBar.success(
            message: message,
            backgroundColor: AppColors.success,
            textStyle: TextStyle(
              fontSize: 12.fontSize,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(8.radius),
          ),
          SnackBarType.info => UnconstrainedBox(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.height,
                horizontal: 16.width,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.radius),
                color: AppColors.yellow,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: 12.fontSize,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  AppSpacing.setHorizontalHeight(12),
                  // SvgImageAsset(
                  //   AppAssetPath.check,
                  //   height: 20.radius,
                  //   width: 20.radius,
                  // ),
                ],
              ),
            ),
          ),
        },
      );
}

enum SnackBarType {
  error,
  success,
  info,
}
