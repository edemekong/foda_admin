import 'package:flutter/cupertino.dart';

import '../themes/app_theme.dart';

class StepperProgressBar extends StatelessWidget {
  final int count;

  const StepperProgressBar({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final borderRaduis = BorderRadius.circular(15);

    return Container(
      height: 8,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRaduis,
        color: AppTheme.black,
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 8,
            width: (count / 100) * (width * 0.7),
            decoration: BoxDecoration(
              color: AppTheme.red,
              borderRadius: borderRaduis,
            ),
          ),
        ],
      ),
    );
  }
}
