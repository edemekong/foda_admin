import 'package:flutter/material.dart';
import 'package:foda_admin/constant/route_name.dart';
import 'package:foda_admin/services/navigation_service.dart';
import '../../components/base_state.dart';
import '../../repositories/user_repository.dart';
import '../../services/get_it.dart';

class DashboardState extends BaseState {
  final userRepo = locate<UserRepository>();
  final navigationService = locate<NavigationService>();

  int currentAppIndexStorage = 0;

  BuildContext get context => locate<NavigationService>().navigatorKey.currentContext!;

  void updateIndex(int index) {
    currentAppIndexStorage = index;
    notifyListeners();
  }

  logOut() {
    userRepo.logout();
    navigatePushReplaceName(authPath);
  }
}
