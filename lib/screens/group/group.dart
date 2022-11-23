import 'package:flutter/material.dart';

import 'activities.dart';
import 'home.dart';
import 'package:bienestar_mobile/widgets/components/drawer.dart';

List _items = [
  {
    'text': 'Inicio',
    'icon': Icons.speed,
    'route': '/',
  },
  {
    'text': 'Mis actividades',
    'icon': Icons.pending_actions_outlined,
    'route': '/activities',
  }
];
MyDrawer drawer = MyDrawer(_items);

class Group extends StatelessWidget {
  const Group({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => Home(drawer);
            break;
          case '/activities':
            builder = (BuildContext context) => Activities(drawer);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
