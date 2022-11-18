import 'package:flutter/material.dart';

import 'package:bienestar_mobile/screens/authentication/authentication.dart';
import 'package:bienestar_mobile/screens/promoter/promoter.dart';


class AppRoutes {
  static const initialRoute = "";

  static Map<String, Widget Function(BuildContext)> routes = {
    "": (BuildContext context) => Authentication(),
    "/promoter": (BuildContext context) => Promoter(),
  };
}
