import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bienestar_mobile/backend/models/response.dart';
import 'package:bienestar_mobile/backend/services/api.dart';
import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:bienestar_mobile/widgets/atoms/text_components.dart';


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
    final api = Provider.of<API>(context, listen: false);
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
              APIResponse response = await api.login(
                _emailController.text,
                _passwordController.text,
              );
              if (response.statusCode != 200) {
                setState(() {
                  error = response.error;
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
