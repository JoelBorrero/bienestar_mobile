import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bienestar_mobile/backend/models/user.dart';
import 'package:bienestar_mobile/backend/services/api.dart';
import 'package:bienestar_mobile/widgets/atoms/text_components.dart';
import 'package:bienestar_mobile/widgets/components/drawer.dart';

class Home extends StatelessWidget {
  final MyDrawer drawer;
  const Home(this.drawer, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final api = Provider.of<API>(context);
    User user = api.user!;
    return Scaffold(
      appBar: AppBar(
        title: textH1(user.role, dark: false),
        backgroundColor: theme.primaryColor,
      ),
      body: Center(
        child: textH1("Home"),
      ),
      drawer: drawer,
    );
  }
}
