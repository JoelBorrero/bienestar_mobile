import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'backend/routes.dart';
import 'backend/services/auth_service.dart';
import 'package:bienestar_mobile/backend/services/wrapper.dart';
import 'package:bienestar_mobile/utils/themes.dart';

void main() => runApp(const BienestarUN());

class BienestarUN extends StatelessWidget {
  const BienestarUN({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        home: const Wrapper(),
        routes: AppRoutes.routes,
        title: 'Bienestar UN',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('es')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
      ),
    );
  }
}
