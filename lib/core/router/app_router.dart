
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/features/auth/presentation/pages/create_account_page.dart';
import 'package:marketplace/features/auth/presentation/pages/dashboard_page.dart';
import 'package:marketplace/features/auth/presentation/pages/edit_profile_page.dart';
import 'package:marketplace/features/auth/presentation/pages/login_page.dart';
import 'package:marketplace/features/auth/presentation/pages/settings_page.dart';
import 'package:marketplace/features/products/presentation/pages/favourite_page.dart';
import 'package:marketplace/features/products/presentation/pages/home_page.dart';
import 'package:marketplace/features/products/presentation/pages/product_detail_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter{

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
        page: LoginRoute.page,
        path: '/',
        initial: true),
    AutoRoute(
        page: CreateAccountRoute.page,
        path: '/createAccount',
        ),
    AutoRoute(
      path: '/dashboard',
      page: DashboardRoute.page,
      children: [
        RedirectRoute(path: '', redirectTo: 'home'),
        AutoRoute(path: 'home', page: HomeRoute.page),
        AutoRoute(path: 'favourite', page: FavouriteRoute.page),
        AutoRoute(path: 'settings', page: SettingsRoute.page),
      ],
    ),
    AutoRoute(path: '/editProfile', page: EditProfileRoute.page),
    AutoRoute(
        page: ProductDetailRoute.page,
        path: '/product-detail',
        ),
  ];
}