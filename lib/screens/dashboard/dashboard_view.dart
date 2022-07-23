import 'package:flutter/material.dart';
import 'package:foda_admin/constant/route_name.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../components/app_scaffold.dart';
import '../../constant/image_path.dart';
import '../../constant/menu.dart';
import '../../models/user.dart';
import '../../services/get_it.dart';
import '../../services/navigation_service.dart';
import '../../themes/app_theme.dart';
import 'dashboard_state.dart';

class DashboardView extends StatefulWidget {
  final String currentPath;
  const DashboardView({
    Key? key,
    required this.currentPath,
  }) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardState>();

    return ValueListenableBuilder<bool>(
      valueListenable: state.userRepo.isAuthenticating,
      builder: (context, isAuthenticating, _) {
        return ValueListenableBuilder<User?>(
          valueListenable: state.userRepo.currentUserNotifier,
          builder: (context, user, _) {
            return ResponsiveBuilder(builder: (context, sizing) {
              final isMobile = sizing.isMobile;
              final isTablet = sizing.isTablet;

              return AppScaffold(
                body: Row(
                  children: [
                    if ((!isTablet && !isMobile)) ...[
                      ValueListenableBuilder<bool>(
                        valueListenable: state.navigationService.showNavigationBar,
                        builder: (context, show, _) {
                          if (!show) return const SizedBox.shrink();
                          return const DashboardDrawer();
                        },
                      ),
                    ],
                    Expanded(
                      child: ClipRRect(
                        child: Navigator(
                          key: state.navigationService.navigatorKey,
                          observers: [RouteObservers()],
                          initialRoute: widget.currentPath,
                          onGenerateRoute: state.navigationService.onGeneratedRoute,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }
}

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardState>();

    return ClipRRect(
      child: Container(
        width: AppTheme.drawerWidth,
        height: AppTheme.size(context).height,
        decoration: const BoxDecoration(
          color: AppTheme.darkBlue,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppTheme.elementSpacing * 0.85),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    navigatePushReplaceName(overview);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                    child: Image.asset(ImagePath.logo, height: 35),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.elementSpacing * 0.85),
            const Divider(color: AppTheme.white, height: 0, thickness: 0.1),
            const SizedBox(height: AppTheme.elementSpacing),
            Expanded(
              child: ListView.builder(
                itemCount: menus.length,
                itemBuilder: (_, index) {
                  final menu = menus[index];
                  return NavigationBarCard(menu: menu);
                },
              ),
            ),
            const Divider(color: AppTheme.white, height: 0, thickness: 0.1),
            const SizedBox(height: AppTheme.cardPadding * 0.5),
            InkWell(
              onTap: state.logOut,
              child: Text(
                'Logout',
                style: Theme.of(context).textTheme.button?.copyWith(color: AppTheme.white, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: AppTheme.elementSpacing),
          ],
        ),
      ),
    );
  }
}

class NavigationBarCard extends StatefulWidget {
  const NavigationBarCard({
    Key? key,
    required this.menu,
  }) : super(key: key);
  final Menu menu;

  @override
  State<NavigationBarCard> createState() => _NavigationBarCardState();
}

class _NavigationBarCardState extends State<NavigationBarCard> {
  final navigationService = locate<NavigationService>();

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final title = widget.menu.title;
    final initialRoute = widget.menu.route;
    final icon = widget.menu.icon;
    final subItems = widget.menu.subRoutes;

    return ValueListenableBuilder<String>(
      valueListenable: navigationService.routeNotifier,
      builder: (context, value, _) {
        final isTapped = initialRoute == value;

        if (subItems.isNotEmpty) {
          return NavigationBarCardList(menu: widget.menu, isTapped: isTapped);
        }

        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing * 0.5),
          child: InkWell(
            onHover: (v) {
              setState(() {
                isHover = v;
              });
            },
            onTap: () {
              navigatePushReplaceName(initialRoute);
            },
            child: Container(
              padding: const EdgeInsets.all(AppTheme.elementSpacing),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isHover ? AppTheme.white.withOpacity(.1) : Colors.transparent,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(),
                    child: Row(
                      children: [
                        Icon(icon, color: isTapped ? AppTheme.red : AppTheme.white),
                        const SizedBox(width: AppTheme.elementSpacing),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color: isTapped ? AppTheme.red : AppTheme.white,
                                fontWeight: isTapped ? FontWeight.w700 : FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavigationBarCardList extends StatelessWidget {
  const NavigationBarCardList({Key? key, required this.menu, required, required this.isTapped}) : super(key: key);

  final Menu menu;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.elementSpacing),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ListTileTheme(
          dense: true,
          horizontalTitleGap: AppTheme.elementSpacing * 1.5,
          minLeadingWidth: 10,
          child: ExpansionTile(
            backgroundColor: AppTheme.white.withOpacity(.1),
            tilePadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.elementSpacing,
              vertical: AppTheme.elementSpacing * 0.25,
            ),
            childrenPadding: const EdgeInsets.only(left: AppTheme.elementSpacing),
            iconColor: AppTheme.white,
            leading: Icon(menu.icon, color: isTapped ? AppTheme.orange : AppTheme.white),
            title: Text(
              menu.title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: isTapped ? AppTheme.red : AppTheme.white,
                    fontWeight: isTapped ? FontWeight.w700 : FontWeight.w500,
                  ),
            ),
            children: List.generate(
              menu.subRoutes.length,
              (index) {
                final menu1 = menu.subRoutes[index];
                return NavigationBarCard(menu: menu1);
              },
            ),
          ),
        ),
      ),
    );
  }
}
