import 'package:flutter/material.dart';

class JSGuruInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const JSGuruInputField({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
