import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foda_admin/constant/route_name.dart';
import 'package:foda_admin/repositories/user_repository.dart';
import 'package:foda_admin/screens/authentication/authentication_state.dart';
import 'package:foda_admin/screens/authentication/authentication_view.dart';
import 'package:foda_admin/screens/dashboard/dashboard_state.dart';
import 'package:foda_admin/screens/dashboard/dashboard_view.dart';
import 'package:foda_admin/services/get_it.dart';
import 'package:foda_admin/services/navigation_service.dart';
import 'package:foda_admin/themes/app_theme.dart';
import 'package:foda_admin/utils/common.dart';
import 'package:provider/provider.dart';

class FodaAdmin extends StatelessWidget {
  const FodaAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationState()),
        ChangeNotifierProvider(create: (context) => DashboardState()),
      ],
      child: MaterialApp.router(
        theme: AppTheme.theme,
        title: 'Foda Admin',
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
        },
        debugShowCheckedModeBanner: false,
        routerDelegate: UrlHandlerRouterDelegate(),
        routeInformationParser: UrlHandlerInformationParser(),
      ),
    );
  }
}

class UrlHandlerRouterDelegate extends RouterDelegate<String> {
  final userRepository = locate<UserRepository>();
  final navigationService = locate<NavigationService>();

  @override
  void addListener(VoidCallback listener) {}

  @override
  Widget build(BuildContext context) {
    return DashboardView(currentPath: navigationService.determineHomePath());
  }

  @override
  Future<bool> popRoute() async {
    return false;
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (userRepository.currentUserUID != null && configuration != authPath) {
      if (!navigationService.pathToCloseNavigationBar.contains(configuration)) {
        navigationService.setNavigationBar = true;
      }
      navigationService.routeNotifier.value = configuration;
      navigationService.navigatorKey.currentState!.pushNamedAndRemoveUntil(configuration, (route) => false);
    } else {
      if (userRepository.currentUserUID == null) {
        navigatePushReplaceName(authPath);
      } else {
        navigatePushReplaceName(overview);
      }
    }
  }
}

class UrlHandlerInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    return "${routeInformation.location}";
  }
}
