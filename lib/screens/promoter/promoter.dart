import 'package:flutter/material.dart';

import 'home.dart';
import 'hours.dart';
import 'package:bienestar_mobile/widgets/modules/drawer.dart';

List _list = [
  {
    'text': 'Inicio',
    'icon': Icons.speed,
    'route': '/',
  },
  {
    'text': 'Mis horas',
    'icon': Icons.pending_actions_outlined,
    'route': '/hours',
  }
];
MyDrawer drawer = MyDrawer(_list);

class Promoter extends StatelessWidget {
  const Promoter({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      // initialRoute: '/',
      initialRoute: '/hours',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => Home(drawer);
            break;
          case '/hours':
            builder = (BuildContext context) => Hours(drawer);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
