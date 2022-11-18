import 'package:bienestar_mobile/screens/authentication/password_recovery.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Authentication extends StatelessWidget {
  Authentication({super.key});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", width: 50, fit: BoxFit.cover),
                textH1("  Bienestar UN", fontSize: 35),
              ],
            ),
            const SizedBox(height: 20),
            Flexible(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Login(controller: _pageController),
                  PasswordRecovery(controller: _pageController)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}