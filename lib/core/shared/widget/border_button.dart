import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({super.key, required this.text, required this.onTap,
    this.width, this.height});
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal:10,vertical: 4 ),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey1),
            borderRadius: BorderRadius.circular(11.radius)
        ),
        child: Center(
          child: Text(
           text,
            style: context.textTheme.bodySmall!.copyWith(
                fontSize: 14.fontSize, color: AppColors.grey1
            ),
          ),
        ),
      ),
    );
  }
}
