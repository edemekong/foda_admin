import 'package:flutter/material.dart';
import 'package:foda_admin/components/foda_button.dart';
import 'package:foda_admin/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../create_food_state.dart';

class Branding extends StatelessWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateFoodState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              state.pickImage();
            },
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.black,
                image: state.imageUnit8List != null ? DecorationImage(image: MemoryImage(state.imageUnit8List!)) : null,
                borderRadius: BorderRadius.circular(15),
              ),
              child: state.imageUnit8List != null
                  ? const SizedBox.shrink()
                  : const Center(
                      child: Icon(
                      Icons.add_a_photo,
                      size: 80,
                    )),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FodaButton(
                title: "Previous",
                gradiant: const [
                  AppTheme.blackLight,
                  AppTheme.blackLight,
                ],
                onTap: () {
                  state.moveToPreviousPage();
                },
              ),
              FodaButton(
                title: "Next",
                state: state.imageUnit8List == null ? ButtonState.disabled : ButtonState.idle,
                onTap: () {
                  state.moveToNexPage();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
