import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foda_admin/components/foda_button.dart';
import 'package:foda_admin/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../create_food_state.dart';

class Summery extends StatelessWidget {
  const Summery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateFoodState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SummeryTextCard(
                title: "Title",
                text: state.titleController.text,
              ),
              const SizedBox(width: AppTheme.cardPadding),
              SummeryTextCard(
                title: "Category",
                text: state.seletedCategory!,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.cardPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image:
                      state.imageUnit8List != null ? DecorationImage(image: MemoryImage(state.imageUnit8List!)) : null,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(width: AppTheme.cardPadding),
              Expanded(
                child: SummeryTextCard(title: "Descripiton", maxLine: 6, text: state.descriptionController.text),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.cardPadding),
          Row(
            children: [
              SummeryTextCard(
                title: "Price",
                text: "\$ ${state.priceController.text}",
              ),
              const SizedBox(width: AppTheme.cardPadding),
              SummeryTextCard(
                title: "Previous Price",
                text: "\$ ${state.previousPriceController.text}",
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              CupertinoSwitch(
                activeColor: AppTheme.red,
                value: state.isLive,
                trackColor: AppTheme.black,
                onChanged: state.setLive,
              ),
              const SizedBox(width: AppTheme.elementSpacing),
              Text(
                "Set Live",
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
          const SizedBox(height: AppTheme.cardPadding),
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
                title: "Publish",
                state: state.isLoading ? ButtonState.loading : ButtonState.idle,
                onTap: state.publishFood,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SummeryTextCard extends StatelessWidget {
  final String title;
  final String text;
  final int maxLine;
  const SummeryTextCard({
    Key? key,
    required this.title,
    required this.text,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: AppTheme.elementSpacing * 0.25),
        Container(
          padding: const EdgeInsets.all(AppTheme.elementSpacing),
          decoration: BoxDecoration(
            color: AppTheme.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SelectableText(
            text,
            maxLines: maxLine,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
