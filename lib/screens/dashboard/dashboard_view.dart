import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/app_scaffold.dart';
import '../../services/navigation_service.dart';
import 'components/navigation_drawer.dart';
import 'dashboard_state.dart';

class DashboardView extends StatelessWidget {
  final String currentPath;
  const DashboardView({Key? key, required this.currentPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardState>();

    return AppScaffold(
      body: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: state.navigationService.showNavigationBar,
            builder: (context, show, _) {
              if (!show) return const SizedBox.shrink();
              return const DashboardDrawer();
            },
          ),
          Expanded(
            child: ClipRRect(
              child: Navigator(
                key: state.navigationService.navigatorKey,
                observers: [RouteObservers()],
                initialRoute: currentPath,
                onGenerateRoute: state.navigationService.onGeneratedRoute,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
