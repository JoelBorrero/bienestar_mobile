import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/themes.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Size? size;
  final double? margin;
  final String? Function(String value)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType,
    this.maxLength,
    this.size,
    this.margin,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget textField = TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: icon != null ? Icon(icon, color: theme.primaryColorDark) : null,
        label: textMedium(label),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      obscureText: keyboardType == TextInputType.visiblePassword,
    );
    return size == null
        ? textField
        : Container(
            width: size!.width,
            height: size!.height,
            margin: EdgeInsets.symmetric(vertical: margin ?? 20),
            child: textField,
          );
  }
}
