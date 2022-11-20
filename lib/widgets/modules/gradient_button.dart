import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  const GradientButton(
      {super.key, required this.text, required this.onPressed, this.width=200});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: gradient(theme),
        borderRadius: BorderRadius.circular(10),
      ),
      width: width,
      child: InkWell(
        onTap: () => onPressed(),
        child: Container(
          alignment: Alignment.center,
          child: textMedium(text, dark: false),
        ),
      ),
    );
  }
}
