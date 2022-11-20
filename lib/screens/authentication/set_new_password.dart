import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class SetNewPassword extends StatefulWidget {
  final PageController controller;
  const SetNewPassword({super.key, required this.controller});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController _passwordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          textH1('Recuperar contraseña\n'),
          textLarge(
            'Estás a un paso de restablecer tu contraseña :)\n',
            textAlign: TextAlign.center,
          ),
          textMedium(
            'Todo está listo! Ahora introduce tu nueva contraseña.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          CustomTextField(
            controller: _passwordController,
            label: 'Contraseña',
            icon: Icons.password,
            keyboardType: TextInputType.visiblePassword,
            size: const Size(300, 50),
            margin: 10,
          ),
          CustomTextField(
            controller: _confirmPasswordController,
            label: 'Validar contraseña',
            icon: Icons.password,
            keyboardType: TextInputType.visiblePassword,
            size: const Size(300, 50),
            margin: 10,
          ),
          GradientButton(
            text: 'Validar',
            onPressed: () {
              if (_passwordController.text != _confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: textMedium('Las contraseñas no coinciden'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: textMedium('Contraseña restablecida'),
                    backgroundColor: Colors.green,
                  ),
                );
                widget.controller
                    .animateToPage(0, duration: duration, curve: curve);
              }
            },
          ),
          TextButton(
            onPressed: () {
              widget.controller
                  .animateToPage(0, duration: duration, curve: curve);
            },
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}
