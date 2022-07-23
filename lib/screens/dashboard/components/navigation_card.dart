import 'package:flutter/material.dart';

import '../../../constant/menu.dart';
import '../../../services/get_it.dart';
import '../../../services/navigation_service.dart';
import '../../../themes/app_theme.dart';

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
