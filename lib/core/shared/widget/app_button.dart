import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text,
    required this.onTap});
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(17),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.radius),
            gradient: AppColors.buttonGradient
        ),
        child: Center(
          child: Text(
            text,
            style: context.textTheme.headlineLarge!.copyWith(
                fontSize: 14.fontSize, color: AppColors.black
            ),
          ),
        ),
      ),
    );
  }
}
