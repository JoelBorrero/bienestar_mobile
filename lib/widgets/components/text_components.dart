import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/themes.dart';


Text textH1(String text, {bool dark = true, double? fontSize}) {
  return Text(text,
      style: lightTheme.textTheme.titleLarge?.copyWith(
        fontSize: fontSize,
          color: dark
              ? lightTheme.primaryColorDark
              : lightTheme.scaffoldBackgroundColor));
}

Text textH2(String text, {bool dark = true}) {
  return Text(text,
      style: lightTheme.textTheme.titleMedium?.copyWith(
          color: dark
              ? lightTheme.primaryColorDark
              : lightTheme.scaffoldBackgroundColor));
}

Text textH3(String text, {bool dark = true}) {
  return Text(text,
      style: lightTheme.textTheme.titleSmall?.copyWith(
          color: dark
              ? lightTheme.primaryColorDark
              : lightTheme.scaffoldBackgroundColor));
}

Text textSmall(String text,
    {bool dark = true, TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    style: lightTheme.textTheme.bodySmall?.copyWith(
        color: dark
            ? lightTheme.primaryColorDark
            : lightTheme.scaffoldBackgroundColor),
    textAlign: textAlign,
  );
}

Text textMedium(String text,
    {bool dark = true,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign? textAlign,
    Color? color}) {
  return Text(
    text,
    style: lightTheme.textTheme.bodyMedium?.copyWith(
      color: color ??
          (dark
              ? lightTheme.primaryColorDark
              : lightTheme.scaffoldBackgroundColor),
      fontWeight: fontWeight,
    ),
    textAlign: textAlign,
  );
}

Text textLarge(String text,
    {bool dark = true,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign? textAlign,
    Color? color}) {
  return Text(
    text,
    style: lightTheme.textTheme.bodyLarge?.copyWith(
      color: color ??
          (dark
              ? lightTheme.primaryColorDark
              : lightTheme.scaffoldBackgroundColor),
      fontWeight: fontWeight,
    ),
    textAlign: textAlign,
  );
}
