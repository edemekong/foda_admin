import 'package:flutter/material.dart';
import 'package:foda_admin/components/app_scaffold.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        title: const Text("Overview"),
      ),
      body: Container(),
    );
  }
}
