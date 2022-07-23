import 'package:flutter/material.dart';
import 'package:foda_admin/constant/route_name.dart';
import 'package:provider/provider.dart';

import '../../../constant/image_path.dart';
import '../../../constant/menu.dart';
import '../../../services/navigation_service.dart';
import '../../../themes/app_theme.dart';
import '../dashboard_state.dart';
import 'navigation_card.dart';

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
