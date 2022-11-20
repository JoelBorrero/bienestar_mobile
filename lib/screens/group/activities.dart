import 'package:bienestar_mobile/backend/models/user.dart';
import 'package:bienestar_mobile/backend/services/auth_service.dart';
import 'package:bienestar_mobile/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:bienestar_mobile/widgets/components/text_components.dart';
import 'package:provider/provider.dart';

import '../../widgets/components/drawer.dart';

class Activities extends StatelessWidget {
  final MyDrawer drawer;
  const Activities(this.drawer, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final authService = Provider.of<AuthService>(context);
    User user = authService.user!;
    return Scaffold(
        appBar: AppBar(
          title: textH1(user.role, dark: false),
          backgroundColor: theme.primaryColor,
        ),
        body: Center(
          child: textH1("Activities group"),
        ),
        drawer: drawer);
  }
}
