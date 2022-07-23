// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foda_admin/components/app_scaffold.dart';
import 'package:foda_admin/screens/dashboard/pages/create_food/create_food_state.dart';
import 'package:foda_admin/screens/dashboard/pages/create_food/pages/branding.dart';
import 'package:foda_admin/screens/dashboard/pages/create_food/pages/details.dart';
import 'package:foda_admin/screens/dashboard/pages/create_food/pages/pricing.dart';
import 'package:foda_admin/screens/dashboard/pages/create_food/pages/summery.dart';
import 'package:foda_admin/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../components/rounded_card.dart';
import '../../components/food_progress.dart';

class CreateFoodPage extends StatelessWidget {
  const CreateFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateFoodState>();
    List<Widget> pages = const [
      FoodDetails(),
      Branding(),
      Pricing(),
      Summery(),
    ];

    return AppScaffold(
      appbar: AppBar(
        title: const Text("Create Food"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding * 2),
        child: RoundedCard(
          padding: const EdgeInsets.all(AppTheme.elementSpacing),
          child: Column(
            children: [
              CreateFoodProgress(
                count: (state.currentPage + 1) * 25,
                onChangePage: (int page) {
                  if (state.visitedPages.contains(page)) {
                    state.animateToPage(page);
                  }
                },
              ),
              SizedBox(height: AppTheme.cardPadding),
              Expanded(
                child: PageView.builder(
                  controller: state.pageController,
                  onPageChanged: state.onChangePage,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreateFoodView extends StatelessWidget {
  const CreateFoodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateFoodState(),
      child: const CreateFoodPage(),
    );
  }
}
