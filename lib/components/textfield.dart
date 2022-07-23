import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FodaTextfield extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final List<String> autofillHints;
  final int? maxLines;
  const FodaTextfield({
    Key? key,
    required this.title,
    this.controller,
    this.maxLines,
    this.inputFormatters,
    this.autofillHints = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        hintText: title,
        contentPadding: const EdgeInsets.all(25),
      ),
    );
  }
}
