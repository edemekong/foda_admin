import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foda_admin/components/foda_button.dart';
import 'package:foda_admin/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../../components/textfield.dart';
import '../create_food_state.dart';

class Pricing extends StatelessWidget {
  const Pricing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateFoodState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FodaTextfield(
                  title: "Price(\$)",
                  controller: state.priceController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.cardPadding),
              Expanded(
                child: FodaTextfield(
                  title: "Previous Price(\$)",
                  controller: state.previousPriceController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
              ),
            ],
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
                state: state.pricingPageIsValid ? ButtonState.idle : ButtonState.disabled,
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
