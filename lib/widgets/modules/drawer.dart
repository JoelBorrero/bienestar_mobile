import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bienestar_mobile/backend/models/user.dart';
import 'package:bienestar_mobile/backend/services/auth_service.dart';
import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class MyDrawer extends StatelessWidget {
  final List items;
  const MyDrawer(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    User user = auth.user!;
    ThemeData theme = Theme.of(context);
    String route = ModalRoute.of(context)!.settings.name!;
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 4,
                  offset: const Offset(-5, 3),
                ),
              ],
              gradient: gradient(theme),
            ),
            child: textH1('${user.firstName} ${user.lastName}', dark: false),
          ),
          ...items
              .map(
                (item) => ListTile(
                  leading: Icon(
                    item['icon'],
                    size: 40,
                  ),
                  title: textLarge(item['text']),
                  selectedColor: theme.splashColor,
                  iconColor: theme.primaryColor,
                  onTap: () => Navigator.pushNamed(context, item['route']),
                  selected: item['route'] == route,
                  selectedTileColor: theme.primaryColor.withOpacity(0.2),
                ),
              )
              .toList(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 40,
            ),
            title: textLarge('Cerrar sesión'),
            iconColor: theme.primaryColor,
            onTap: () {
              auth.logout();
            },
          ),
        ],
      ),
    );
  }
}
