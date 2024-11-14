import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/core/router/app_router.dart';
import 'package:marketplace/core/shared/wrapper/scaffold_wrapper.dart';
import 'package:marketplace/core/utils/app_assets.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:marketplace/features/products/presentation/manager/product_riverpod.dart';
import 'package:marketplace/features/products/presentation/widgets/category_card.dart';
import 'package:marketplace/features/products/presentation/widgets/product_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ScaffoldWrapper(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header(),
        AppSpacing.setVerticalHeight(30),
        Expanded(child: _Body(ref))
      ],
    ));
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(AppAssets.menu),
        SvgPicture.asset(AppAssets.search),
      ],
    );
  }
}

class _Body extends HookWidget {
  _Body(this.ref);
 final  WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState('Donuts');
    useEffect((){
      ref.read(product).categories();
      ref.read(product).getProducts();
      return null;
    },[]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Some sweets of",
          style: context.textTheme.headlineLarge!.copyWith(
            fontSize: 36.fontSize,
          ),
        ),
        Text(
          "Happiness!",
          style: context.textTheme.bodySmall!
              .copyWith(fontSize: 24.fontSize, fontWeight: FontWeight.w200),
        ),
        AppSpacing.setVerticalHeight(30),
        Skeletonizer(
          enabled: ref.watch(product).isBusy,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  ref.watch(product).category.length,
                  (index) {
                    final category = ref.watch(product).category[index];
                    return CategoryCard(
                        name: category.name,
                        selected: selectedCategory.value == category.name,
                        onTap: () => selectedCategory.value = category.name,
                      );}),
            ),
          ),
        ),
        AppSpacing.setVerticalHeight(33),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 29.width,
                mainAxisSpacing: 30.height,
                mainAxisExtent: 260.height),
            itemCount:  ref.watch(product).products.length,
            itemBuilder: (context, index) {
              final marketProduct = ref.watch(product).products[index];
              return Skeletonizer(
                enabled: ref.watch(product).isBusy,
                child: ProductCard(
                  imageLink: marketProduct.images.first,
                  name:marketProduct.title ,
                  info:marketProduct.description ,
                  price: '${marketProduct.price}',
                  onTap: () {
                   context.router.push( ProductDetailRoute(
                       productId: marketProduct.id,  ));
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
