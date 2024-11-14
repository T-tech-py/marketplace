import 'package:flutter/material.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';

class Counter extends StatelessWidget {
  const Counter({super.key, required this.unit});
  final ValueNotifier<int> unit;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        InkWell(
          onTap: ()=> unit.value <2? null: unit.value --,
          child: Icon(Icons.remove_circle_outline,size: 27.radius,
            color:unit.value <2? AppColors.grey1:AppColors.yellow,),
        ),
        AppSpacing.setHorizontalHeight(16),
        Text(
          '${unit.value}',
          style: context.textTheme.bodyMedium!
              .copyWith(fontSize: 16.fontSize,
              color: AppColors.yellow),
        ),

        AppSpacing.setHorizontalHeight(16),
        InkWell(
          onTap: ()=> unit.value ++,
          child: Icon(Icons.add_circle_outline_outlined,size: 27.radius,
            color: AppColors.yellow,),
        ),
      ],
    );
  }
}