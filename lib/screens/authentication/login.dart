import 'package:bienestar_mobile/backend/services/auth_service.dart';
import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/utils/themes.dart';
import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

dynamic _response;

class Login extends StatelessWidget {
  final PageController controller;
  Login({super.key, required this.controller});

  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 20,
      ),
      child: Column(
        children: [
          textH1('Iniciar sesión\n'),
          CustomTextField(
              controller: _emailController, label: 'Email', icon: Icons.email),
          const SizedBox(height: 20),
          CustomTextField(
              controller: _passwordController,
              label: 'Contraseña',
              icon: Icons.password),
          const SizedBox(height: 20),
          GradientButton(
            text: 'Login',
            onPressed: () async {
              // _response = await authService.login("user@example.com", "123");
              // if (_response.success) {
              //   Navigator.pushNamed(context, "/promoter");
              // }
              print("object");
            },
          ),
          const SizedBox(height: 50),
          textMedium('¿Olvidaste tu contraseña?'),
          TextButton(
            onPressed: () {
              controller.nextPage(duration: duration, curve: curve);
            },
            child: const Text('Recupérala'),
          ),
        ],
      ),
    );
  }
}
