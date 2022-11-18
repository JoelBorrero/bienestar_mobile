import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'backend/routes.dart';
import 'backend/services/auth_service.dart';
import 'package:bienestar_mobile/utils/themes.dart';


void main() => runApp(const BienestarUN());

class BienestarUN extends StatelessWidget {
  const BienestarUN({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => AuthService(),
      child: MaterialApp(
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initialRoute,
        title: 'Buenestar UN',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}