import 'package:flutter/material.dart';

import 'package:bienestar_mobile/widgets/atoms/text_components.dart';

class CustomDropdown extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Map<String, Object>> items;
  final dynamic value;
  final Function(dynamic) onChanged;
  final String? Function(dynamic value)? validator;
  final bool? hasInteractedByUser;
  const CustomDropdown(
      {super.key,
      required this.icon,
      required this.label,
      required this.items,
      this.value,
      required this.onChanged,
      this.validator,
      this.hasInteractedByUser});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 25, color: theme.primaryColorDark),
            const SizedBox(width: 20),
            textMedium('$label    '),
            DropdownButton(
              items: items
                  .map((item) => DropdownMenuItem(
                      value: item['value'],
                      child: textMedium(item['label'] as String)))
                  .toList(),
              value: value,
              onChanged: ((val) => onChanged(val)),
            ),
          ],
        ),
        if (validator!(value) != null && (hasInteractedByUser ?? false))
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: textSmall(
              validator!(value)!,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
      ],
    );
  }
}
