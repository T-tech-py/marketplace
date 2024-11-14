import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/core/l10n/l10n.dart';
import 'package:marketplace/core/router/app_router.dart';
import 'package:marketplace/core/utils/colors.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        FavouriteRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          backgroundColor: AppColors.lightBlack,
          selectedItemColor: AppColors.yellow,
          unselectedItemColor: AppColors.grey1,
          items:   [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_max_outlined,),
              activeIcon:  const Icon(Icons.home_max_outlined,),
              label: localization.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border) ,
              activeIcon:const Icon(Icons.favorite_outlined) ,
              label: localization.favourite,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined) ,
              activeIcon:const Icon(Icons.settings_suggest_outlined) ,
              label: localization.settings,
            ),
          ],
        );
      },
    );
  }
}