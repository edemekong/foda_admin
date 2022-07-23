import 'package:flutter/material.dart';
import 'package:foda_admin/components/app_scaffold.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        title: const Text("Orders"),
      ),
      body: Container(),
    );
  }
}
