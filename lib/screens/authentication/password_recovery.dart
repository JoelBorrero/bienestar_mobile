import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class PasswordRecovery extends StatefulWidget {
  final PageController controller;
  PasswordRecovery({super.key, required this.controller});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
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
          textLarge('No te preocupes, estamos para ayudarte :)\n',
              textAlign: TextAlign.center),
          textMedium(
              'Enviaremos un código de verificación a tu correo electrónico o teléfono móvil para que puedas recuperarla.',
              textAlign: TextAlign.center),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textMedium('Método de envío    '),
              DropdownButton(
                  items: [
                    DropdownMenuItem(
                        value: 'email', child: textMedium('Email')),
                    DropdownMenuItem(
                        value: 'sms', child: textMedium('Teléfono')),
                  ],
                  value: sendingMethod,
                  onChanged: (value) {
                    setState(() {
                      sendingMethod = value!;
                    });
                  }),
            ],
          ),
          Container(
            width: 300,
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: CustomTextField(
                controller: sendingController,
                label: sendingMethod == 'sms' ? 'Teléfono' : 'Email',
                icon: sendingMethod == 'sms' ? Icons.phone : Icons.email,
                keyboardType: sendingMethod == 'sms'
                    ? TextInputType.phone
                    : TextInputType.emailAddress),
          ),
          GradientButton(
              text: 'Enviar código',
              onPressed: () {
                print(sendingController.text);
              }),
          TextButton(
              onPressed: () {
                widget.controller
                    .previousPage(duration: duration, curve: curve);
              },
              child: const Text('Iniciar sesión')),
        ],
      ),
    );
  }
}
