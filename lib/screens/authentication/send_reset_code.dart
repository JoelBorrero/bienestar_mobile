import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/constants.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

class SendResetCode extends StatefulWidget {
  final PageController controller;
  const SendResetCode({super.key, required this.controller});

  @override
  State<SendResetCode> createState() => _SendResetCodeState();
}

class _SendResetCodeState extends State<SendResetCode> {
  String _sendingMethod = 'email';
  final TextEditingController _sendingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          textH1('Recuperar contraseña\n'),
          textLarge(
            'No te preocupes, estamos para ayudarte :)\n',
            textAlign: TextAlign.center,
          ),
          textMedium(
            'Enviaremos un código de verificación a tu correo electrónico o teléfono móvil para que puedas recuperarla.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textMedium('Método de envío    '),
              DropdownButton(
                items: [
                  DropdownMenuItem(value: 'email', child: textMedium('Email')),
                  DropdownMenuItem(value: 'sms', child: textMedium('Teléfono')),
                ],
                value: _sendingMethod,
                onChanged: (value) {
                  setState(() {
                    _sendingMethod = value!;
                  });
                },
              ),
            ],
          ),
          CustomTextField(
            controller: _sendingController,
            label: _sendingMethod == 'sms' ? 'Teléfono' : 'Email',
            icon: _sendingMethod == 'sms' ? Icons.phone : Icons.email,
            keyboardType: _sendingMethod == 'sms'
                ? TextInputType.phone
                : TextInputType.emailAddress,
            size: const Size(300, 50),
          ),
          GradientButton(
            text: 'Enviar código',
            onPressed: () {
              print('Sending code to ${_sendingController.text}');
              widget.controller.nextPage(duration: duration, curve: curve);
            },
          ),
          TextButton(
            onPressed: () {
              widget.controller.previousPage(duration: duration, curve: curve);
            },
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}
