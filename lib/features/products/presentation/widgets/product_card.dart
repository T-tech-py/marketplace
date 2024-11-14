import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/core/utils/app_assets.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.imageLink,
    required this.name, required this.info,
    required this.price, required this.onTap,
     this.isDeleteIcon = false, this.onTapIcon});
  final String imageLink;
  final String name;
  final String info;
  final String price;
  final bool isDeleteIcon;
  final VoidCallback onTap;
  final VoidCallback? onTapIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.radius),
          color: AppColors.cardBlack,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(15.radius),
                  child: CachedNetworkImage(
                    imageUrl: imageLink,
                    placeholder: (context, url) =>SvgPicture.asset(
                        AppAssets.placeholder, height: 73.height),
                    errorWidget: (context, url, error) =>
                        SvgPicture.asset(AppAssets.placeholder,
                            height: 73.height),
                  ),
                ) ,),
            AppSpacing.setVerticalHeight(23),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.headlineLarge!.copyWith(
                fontSize: 14.fontSize,
              ),
            ),
            AppSpacing.setVerticalHeight(8),
            Text(
              info,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: 12.fontSize,
              ),
            ),
            AppSpacing.setVerticalHeight(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.headlineLarge!.copyWith(
                    fontSize: 14.fontSize,
                  ),
                ),
                InkWell(
                    onTap:  isDeleteIcon? onTapIcon:(){},
                    child:  Icon(
                      isDeleteIcon? Icons.close : Icons.add,
                      color: AppColors.yellow,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
