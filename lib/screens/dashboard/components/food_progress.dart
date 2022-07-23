import 'package:flutter/material.dart';

import '../../../components/stepper.dart';
import '../../../constant/menu.dart';
import '../../../themes/app_theme.dart';

List<Menu> tabs = const [
  Menu(title: 'Details', icon: Icons.folder_copy),
  Menu(icon: Icons.photo_camera_rounded, title: 'Branding'),
  Menu(icon: Icons.monetization_on, title: 'Pricing'),
  Menu(icon: Icons.summarize_outlined, title: 'Summery'),
];

class CreateFoodProgress extends StatelessWidget {
  final Function(int) onChangePage;
  const CreateFoodProgress({
    Key? key,
    required this.count,
    required this.onChangePage,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: Stack(
          children: [
            Positioned(
              top: 35,
              child: StepperProgressBar(count: count),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                tabs.length,
                (index) {
                  final hightlight = (index + 1) * 25;

                  return InkWell(
                    onTap: () {
                      onChangePage(index);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: hightlight <= count ? AppTheme.red : AppTheme.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              tabs[index].icon,
                              size: 50,
                              color: hightlight <= count ? AppTheme.white : AppTheme.blackLight,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.elementSpacing),
                        Text(
                          tabs[index].title,
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: hightlight <= count ? AppTheme.white : AppTheme.white.withOpacity(.5)),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
