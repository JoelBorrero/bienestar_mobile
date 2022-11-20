import 'package:flutter/material.dart';

import 'package:bienestar_mobile/screens/group/group.dart';
import 'package:bienestar_mobile/screens/promoter/promoter.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/promoter": (BuildContext context) => const Promoter(),
    "/group": (BuildContext context) => const Group(),
  };
}
