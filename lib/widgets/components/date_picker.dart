import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/themes.dart';
import 'package:bienestar_mobile/widgets/atoms/text_components.dart';

DateTime _now = DateTime.now();
TextEditingController _startDateController = TextEditingController();

class DatePicker extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) updateDate;
  final String? Function(String? value)? validator;
  const DatePicker(
      {super.key,
      required this.date,
      required this.updateDate,
      this.validator});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      controller: _startDateController,
      decoration: InputDecoration(
        icon: Icon(
          Icons.calendar_today,
          color: theme.primaryColorDark,
        ),
        label: textMedium('Fecha de inicio'),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
      ),
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: _now,
          firstDate: DateTime(_now.year, _now.month, _now.day - 7),
          lastDate: _now,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          helpText: 'Selecciona tu fecha',
          cancelText: 'Cancelar',
          confirmText: 'Aceptar',
        );
        if (selectedDate != null) {
            updateDate(selectedDate);
            _startDateController.text =
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        }
      },
      validator: validator,
    );
  }
}
