import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bienestar_mobile/backend/models/user.dart';
import 'package:bienestar_mobile/backend/services/auth_service.dart';
import 'package:bienestar_mobile/screens/promoter/add_report.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';
import 'package:bienestar_mobile/widgets/modules/drawer.dart';

class Hours extends StatelessWidget {
  final MyDrawer drawer;
  const Hours(this.drawer, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final authService = Provider.of<AuthService>(context);
    User user = authService.user!;
    return Scaffold(
        appBar: AppBar(
          title: textH1('Mis horas', dark: false),
          backgroundColor: theme.primaryColor,
        ),
        body: Center(
          child: textH1("Promoter hours"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              showModalBottomSheet(context: context, builder: (context) => const AddReport()),
          backgroundColor: theme.primaryColor,
          child: const Icon(Icons.add),
        ),
        drawer: drawer);
  }
}
