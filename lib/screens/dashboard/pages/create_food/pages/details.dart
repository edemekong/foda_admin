import 'package:flutter/material.dart';
import 'package:foda_admin/components/foda_button.dart';
import 'package:foda_admin/components/textfield.dart';
import 'package:foda_admin/themes/app_theme.dart';
import 'package:foda_admin/utils/common.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/food_categories.dart';
import '../create_food_state.dart';

class FoodDetails extends StatelessWidget {
  const FoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateFoodState>();

    fodaPrint(state.detailPageIsValid);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        children: [
          FodaTextfield(
            title: "Title",
            controller: state.titleController,
          ),
          const SizedBox(height: AppTheme.elementSpacing),
          FodaTextfield(
            controller: state.descriptionController,
            title: "Description",
            maxLines: 6,
          ),
          const SizedBox(height: AppTheme.cardPadding),
          DropdownButtonFormField<String>(
            dropdownColor: AppTheme.darkBlue,
            hint: Text(
              "Select Category",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.white.withOpacity(.6)),
            ),
            items: categories
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.white),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              state.setCategory(value!);
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FodaButton(
                title: "Next",
                state: state.detailPageIsValid ? ButtonState.idle : ButtonState.disabled,
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
