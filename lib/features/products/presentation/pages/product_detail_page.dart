import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/core/shared/widget/app_button.dart';
import 'package:marketplace/core/shared/widget/border_button.dart';
import 'package:marketplace/core/shared/wrapper/scaffold_wrapper.dart';
import 'package:marketplace/core/utils/app_assets.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';
import 'package:marketplace/features/products/presentation/manager/favourite_riverpod.dart';
import 'package:marketplace/features/products/presentation/manager/product_riverpod.dart';
import 'package:marketplace/features/products/presentation/widgets/counter.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({required this.productId, super.key});
  final int productId;
  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  ProductRiverPod? productData;
  @override
  void initState() {
    productData = ref.read(product);
    // SchedulerBinding.instance.addPostFrameCallback((_){
    productData?.getProduct(widget.productId).then((value) => setState(() {}));
   //  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: productData?.isBusy ?? false,
      child: ScaffoldWrapper(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              productEntity: productData?.productEntity,
              id: widget.productId,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.setVerticalHeight(33),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.radius),
                      child: CachedNetworkImage(
                        imageUrl: productData?.productEntity?.images.first ?? '',
                        placeholder: (context, url) => SvgPicture.asset(
                          AppAssets.placeholder,
                          height: 280.height,
                          width: 330.width,
                        ),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                          AppAssets.placeholder,
                          height: 280.height,
                          width: 330.width,
                        ),
                      ),
                    ),
                    AppSpacing.setVerticalHeight(46),
                    Text(
                      productData?.productEntity?.title ?? "Unicorn Sprinkles",
                      style: context.textTheme.headlineLarge!.copyWith(
                        fontSize: 24.fontSize,
                      ),
                    ),
                    Text(
                      productData?.productEntity?.description ??
                          "A fluffy fresh "
                              "cooked donut covered by a creamy strawberry flavour with rainbow sprinkles.",
                      style: context.textTheme.bodySmall!.copyWith(
                          fontSize: 16.fontSize, fontWeight: FontWeight.w200),
                    ),
                    AppSpacing.setVerticalHeight(33),
                    PriceTag(
                      price: productData?.productEntity?.price ?? 0,
                    ),
                    AppSpacing.setVerticalHeight(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Need more?',
                          style: context.textTheme.bodySmall!.copyWith(
                            fontSize: 16.fontSize,
                          ),
                        ),
                        BorderButton(
                          text: 'Add more',
                          onTap: () {},
                        ),
                      ],
                    ),
                    AppSpacing.setVerticalHeight(46),
                    AppButton(
                      text: 'Add to cart',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.setVerticalHeight(30),
          ],
        ),
      ),
    );
  }
}

class PriceTag extends HookWidget {
  const PriceTag({required this.price, super.key});
  final int price;
  @override
  Widget build(BuildContext context) {
    final unit = useState(1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Counter(
          unit: unit,
        ),
        Text(
          "\$${price * unit.value}",
          style: context.textTheme.headlineLarge!.copyWith(
            fontSize: 24.fontSize,
          ),
        ),
      ],
    );
  }
}


class Header extends ConsumerStatefulWidget {
  const Header({required this.productEntity,required this.id,
    super.key});
  final ProductEntity? productEntity;
  final int id;
  @override
  ConsumerState<Header> createState() => _HeaderConsumerState();
}

class _HeaderConsumerState extends ConsumerState<Header> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_){
      ref.read(favouriteRiverPod).checkIsSelected(widget.id);
      ref.read(favouriteRiverPod).getFavourites(); });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(),
        IconButton(
            onPressed: () =>
                ref.watch(favouriteRiverPod).setIsSelected(widget.productEntity),
            icon: Icon(
              !ref.watch(favouriteRiverPod).isSelected
                  ? Icons.favorite_border
                  : Icons.favorite_outlined,
              color: AppColors.yellow,
            ))
      ],
    );
  }
}
