import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bienestar_mobile/backend/services/auth_service.dart';
import 'package:bienestar_mobile/screens/authentication/authentication.dart';
import 'package:bienestar_mobile/screens/group/group.dart';
import 'package:bienestar_mobile/screens/promoter/promoter.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

// Future waitForUser(AuthService auth) async {
//   return await auth.user;
// }

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return auth.user == null
        ? Authentication()
        : auth.user!.role == 'promotor'
            ? const Promoter()
            : const Group();
  }
}
