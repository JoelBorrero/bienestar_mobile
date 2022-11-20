import 'package:bienestar_mobile/backend/services/auth_service.dart';
import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/utils/themes.dart';
import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

dynamic _response;

class Login extends StatefulWidget {
  final PageController controller;
  const Login({super.key, required this.controller});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController =
          TextEditingController(text: 'promotor@example.com'), _passwordController = TextEditingController(text: '123');
          // TextEditingController(text: 'bk2@uninorte.edu.co'), _passwordController = TextEditingController(text: 'uninorte');

  String? error = '';

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
            controller: _emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _passwordController,
            label: 'Contraseña',
            icon: Icons.password,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 20),
          GradientButton(
            text: 'Login',
            onPressed: () async {
              _response = await authService.login(
                _emailController.text,
                _passwordController.text,
              );
              if (!_response.success) {
                setState(() {
                  error = _response.error;
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: textMedium(error ?? '', color: Colors.red),
          ),
          textMedium('¿Olvidaste tu contraseña?'),
          TextButton(
            onPressed: () {
              widget.controller.nextPage(duration: duration, curve: curve);
            },
            child: const Text('Recupérala'),
          ),
        ],
      ),
    );
  }
}
