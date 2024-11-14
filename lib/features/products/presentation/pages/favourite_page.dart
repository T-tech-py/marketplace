import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/core/l10n/l10n.dart';
import 'package:marketplace/core/router/app_router.dart';
import 'package:marketplace/core/shared/wrapper/scaffold_wrapper.dart';
import 'package:marketplace/core/utils/app_assets.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:marketplace/features/products/presentation/manager/favourite_riverpod.dart';
import 'package:marketplace/features/products/presentation/widgets/product_card.dart';

@RoutePage()
class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({super.key});
  @override
  ConsumerState<FavouritePage> createState() => _FavouritePageConsumerState();
}

class _FavouritePageConsumerState extends ConsumerState<FavouritePage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(favouriteRiverPod).getFavourites();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appString = context.l10n;
    return ScaffoldWrapper(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Text(
              appString.favourite,
              style: context.textTheme.headlineMedium,
            ),
            const Spacer(),
            IconButton(
                onPressed: () => ref.read(favouriteRiverPod).clearFavourites(),
                icon: const Icon(
                  Icons.delete_forever,
                  color: AppColors.red,
                )),
          ],
        ),
        AppSpacing.setVerticalHeight(44),
        Expanded(
          child: ref.watch(favouriteRiverPod).favourites.isEmpty
              ? EmptyState(
                  image: AppAssets.cart,
                  text: appString.youAreYetToAddAnItemToYourFavoriteList,
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 29.width,
                      mainAxisSpacing: 30.height,
                      mainAxisExtent: 260.height),
                  itemCount: ref.watch(favouriteRiverPod).favourites.length,
                  itemBuilder: (context, index) {
                    final marketProduct =
                        ref.watch(favouriteRiverPod).favourites[index];
                    return ProductCard(
                      imageLink: marketProduct.images.first,
                      name: marketProduct.title,
                      info: marketProduct.description,
                      price: '${marketProduct.price}',
                      isDeleteIcon: true,
                      onTapIcon: () => ref
                          .watch(favouriteRiverPod)
                          .deleteFavourite(marketProduct),
                      onTap: () {
                        context.router.push(ProductDetailRoute(
                          productId: marketProduct.id,
                        ));
                      },
                    );
                  },
                ),
        ),
      ],
    ));
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          AppSpacing.setVerticalHeight(20),
          Text(
            text,
            style: context.textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
