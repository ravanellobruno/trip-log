import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const InputText({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
    );
  }
}
