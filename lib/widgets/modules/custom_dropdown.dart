import 'package:flutter/material.dart';

import 'package:bienestar_mobile/widgets/components/text_components.dart';

class CustomDropdown extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Map<String, Object>> items;
  final dynamic value;
  final Function(dynamic) onChanged;
  const CustomDropdown({super.key, required this.icon, required this.label, required this.items, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 25, color: theme.primaryColorDark),
        const SizedBox(width: 20),
        textMedium('$label    '),
        DropdownButton(
            items: items.map((item) => 
            DropdownMenuItem(
                value: item['value'],
                child: textMedium(item['label'] as String)
              )).toList(),
            value: value,
            onChanged: ((val) => onChanged(val))),
      ],
    );
  }
}
