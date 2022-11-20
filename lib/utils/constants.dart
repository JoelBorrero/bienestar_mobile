import 'package:flutter/material.dart';

Curve curve = Curves.fastOutSlowIn;
Duration duration = const Duration(milliseconds: 700);

LinearGradient gradient(ThemeData theme) => LinearGradient(
      colors: [theme.primaryColorDark, theme.splashColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
