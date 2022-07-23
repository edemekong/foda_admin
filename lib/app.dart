import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foda_admin/route_delegates.dart';
import 'package:foda_admin/screens/authentication/authentication_state.dart';
import 'package:foda_admin/screens/dashboard/dashboard_state.dart';
import 'package:foda_admin/themes/app_theme.dart';
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
