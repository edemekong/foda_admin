// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:foda_admin/screens/authentication/authentication_view.dart';
import 'package:foda_admin/screens/dashboard/pages/customers/customers_page.dart';
import 'package:foda_admin/screens/dashboard/pages/feedbacks/feedbacks_page.dart';
import 'package:foda_admin/screens/dashboard/pages/orders/orders_page.dart';
import 'package:foda_admin/screens/dashboard/pages/transactions/transactions_page.dart';

import '../constant/route_name.dart';
import '../repositories/user_repository.dart';
import '../screens/dashboard/pages/create_category/create_category_page.dart';
import '../screens/dashboard/pages/create_food/create_food_page.dart';
import '../screens/dashboard/pages/foods/foods_page.dart';
import '../screens/dashboard/pages/overview/overview_page.dart';
import 'get_it.dart';
import 'dart:html' as html;

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  UserRepository userRepo = locate<UserRepository>();

  ValueNotifier<String> routeNotifier = ValueNotifier<String>(authPath);

  ValueNotifier<bool> showNavigationBar = ValueNotifier<bool>(false);

  List<String> pathToCloseNavigationBar = [
    authPath,
  ];

  set setNavigationBar(bool value) {
    showNavigationBar.value = value;
    showNavigationBar.notifyListeners();
  }

  String determineHomePath() {
    if (userRepo.currentUserUID != null) {
      return overview;
    }
    return authPath;
  }

  Route? onGeneratedRoute(RouteSettings settings) {
    html.window.history.pushState(null, 'foda', "#${settings.name}");

    switch (settings.name) {
      case authPath:
        return navigateToPageRoute(settings, const AuthenticationView());
      case overview:
        return navigateToPageRoute(settings, const OverviewPage());
      case customerPath:
        return navigateToPageRoute(settings, const CustomersPage());
      case ordersPath:
        return navigateToPageRoute(settings, const OrdersPage());
      case foodsPath:
        return navigateToPageRoute(settings, const FoodsPage());
      case feedbackPath:
        return navigateToPageRoute(settings, const FeedbacksPage());
      case transactionPath:
        return navigateToPageRoute(settings, const TransactionsPage());

      case createCategoryPath:
        return navigateToPageRoute(settings, const CreateCategoryPage());
      case createFoodPath:
        return navigateToPageRoute(settings, const CreateFoodView());
    }
    return null;
  }

  PageRoute navigateToPageRoute(RouteSettings settings, Widget page,
      {bool maintainState = true, bool fullscreenDialog = false}) {
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => page,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  void navigatePushReplaceName(String path) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(path, (route) => false);
  }
}

class RouteObservers extends RouteObserver<PageRoute<dynamic>> {
  final navigationService = locate<NavigationService>();

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      final settings = previousRoute.settings;
      if (settings.name != '/') {
        final routeList = settings.name?.split("?").toList();
        String routePath = routeList?[0] ?? authPath;
        navigationService.routeNotifier.value = routePath;

        final containPreviousRoutePath =
            navigationService.pathToCloseNavigationBar.contains(previousRoute.settings.name);

        if (containPreviousRoutePath) {
          navigationService.setNavigationBar = false;
        }

        if (!containPreviousRoutePath) {
          navigationService.setNavigationBar = true;
        }
      }
    }
    super.didPop(route!, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      final settings = route.settings;

      if (settings.name != '/') {
        final routeList = settings.name?.split("?").toList();
        String routePath = routeList?[0] ?? authPath;
        navigationService.routeNotifier.value = routePath;

        final paths = navigationService.pathToCloseNavigationBar;
        final containRoutePath = paths.contains(route.settings.name);

        if (containRoutePath) {
          navigationService.setNavigationBar = false;
        } else {
          navigationService.setNavigationBar = true;
        }
      }
    }
    super.didPush(route, previousRoute);
  }
}

void navigatePushReplaceName(String path) {
  locate<NavigationService>().navigatePushReplaceName(path);
}
