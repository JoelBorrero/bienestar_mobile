import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/themes.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType? keyboardType;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.icon,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: icon != null ? Icon(icon, color: theme.primaryColorDark) : null,
        label: textMedium(label),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }
}
