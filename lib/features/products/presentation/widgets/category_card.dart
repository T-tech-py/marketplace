import 'package:flutter/material.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.name,
      required this.selected,
      required this.onTap});
  final String name;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.width, vertical: 9.height),
        decoration: BoxDecoration(
            color: selected ? AppColors.yellow : AppColors.transparent,
            borderRadius: BorderRadius.circular(12.radius)),
        child: Text(
          name,
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 14.fontSize,
            color: selected ? AppColors.lightBlack : AppColors.grey1,
          ),
        ),
      ),
    );
  }
}
