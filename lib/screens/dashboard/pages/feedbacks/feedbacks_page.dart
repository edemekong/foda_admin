import 'package:flutter/material.dart';
import 'package:foda_admin/components/app_scaffold.dart';

class FeedbacksPage extends StatelessWidget {
  const FeedbacksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        title: const Text("Feedbacks"),
      ),
      body: Container(),
    );
  }
}
