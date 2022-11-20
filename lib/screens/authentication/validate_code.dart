import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class ValidateCode extends StatefulWidget {
  final PageController controller;
  const ValidateCode({super.key, required this.controller});

  @override
  State<ValidateCode> createState() => _ValidateCodeState();
}

class _ValidateCodeState extends State<ValidateCode> {
  String sendingMethod = 'email';
  final TextEditingController sendingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 20,
      ),
      child: Column(
        children: [
          textH1('Recuperar contraseña\n'),
          textLarge(
            'Estás a un paso de validar tu identidad :)\n',
            textAlign: TextAlign.center,
          ),
          textMedium(
            'Enviamos tu código de verificación. Introducelo para continuar.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          CustomTextField(
            controller: sendingController,
            label: 'Código de verificación',
            icon: Icons.view_module_rounded,
            keyboardType: TextInputType.number,
            maxLength: 6,
            size: const Size(300, 70),
          ),
          GradientButton(
            text: 'Validar',
            onPressed: () {
              print('Validation code: ${sendingController.text}');
              widget.controller.nextPage(duration: duration, curve: curve);
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
