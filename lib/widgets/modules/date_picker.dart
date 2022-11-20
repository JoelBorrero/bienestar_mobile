import 'package:flutter/material.dart';

import 'package:bienestar_mobile/utils/themes.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

DateTime _now = DateTime.now();
TextEditingController _startDateController = TextEditingController();

class DatePicker extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) updateDate;
  const DatePicker(
      {super.key,
      required this.date,
      required this.updateDate});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextField(
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
          // TimeOfDay? selectedTime = await showTimePicker(
          //   context: context,
          //   initialTime: TimeOfDay.now(),
          // );
          // if (selectedTime != null) {
            updateDate(selectedDate);
            _startDateController.text =
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
          // }
        }
        // showTimePicker(context: context, initialTime: DateTime.now().);
      },
    );
  }
}
