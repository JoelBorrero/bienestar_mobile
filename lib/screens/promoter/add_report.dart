import 'package:flutter/material.dart';

import 'package:bienestar_mobile/widgets/components/text_components.dart';
import 'package:bienestar_mobile/widgets/modules/custom_dropdown.dart';
import 'package:bienestar_mobile/widgets/modules/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/modules/date_picker.dart';

List _hours = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
DateTime _date = DateTime.now();
int? _startHour = TimeOfDay.now().hour, _endHour;
bool? _wasSupervised;
Map<String, Object?> _answers = {
  'date': _date,
  'start_hour': _startHour,
  'end_hour': _endHour,
  'was_supervised': _wasSupervised,
};

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  void _onChanged(String key, dynamic value) {
    setState(() {
      _answers[key] = value;
      switch (key) {
        case 'date':
          _date = value;
          break;
        case 'start_hour':
          _startHour = value;
          break;
        case 'end_hour':
          _endHour = value;
          break;
        case 'was_supervised':
          _wasSupervised = value;
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_hours.sublist(0, _hours.length - 1).contains(_startHour)) {
      if (_startHour! < _hours[0]) {
        _startHour = _hours[0];
      } else {
        _startHour = _hours[_hours.length - 2];
      }
    }
    _endHour ??= _startHour! + 1;
    final formKey = GlobalKey<FormState>();
    final TextEditingController callController = TextEditingController();
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Form(
          key: formKey,
          child: ListView(
            children: [
              textH2('Nuevo reporte\n'),
              DatePicker(
                date: _date,
                updateDate: (date) => _onChanged('date', date),
              ),
              Row(children: [
                Icon(Icons.alarm, size: 25, color: theme.primaryColorDark),
                const SizedBox(width: 20),
                DropdownButton(
                  value: _startHour,
                  items: _hours
                      .map(
                        (hour) => DropdownMenuItem(
                          value: hour,
                          enabled: hour < _endHour,
                          child: textMedium('$hour:30',
                              color: hour < _endHour
                                  ? theme.primaryColorDark
                                  : Colors.grey),
                        ),
                      )
                      .toList()
                      .sublist(0, _hours.length - 1),
                  onChanged: (hour) => _onChanged('start_hour', hour),
                ),
                DropdownButton(
                  value: _endHour,
                  items: _hours
                      .map(
                        (hour) => DropdownMenuItem(
                          value: hour,
                          enabled: hour > _startHour,
                          child: textMedium('$hour:30',
                              color: hour > _startHour
                                  ? theme.primaryColorDark
                                  : Colors.grey),
                        ),
                      )
                      .toList()
                      .sublist(1),
                  onChanged: (hour) => _onChanged('end_hour', hour),
                ),
                textMedium(
                    '    ${_endHour! - _startHour!} hora${_endHour! - _startHour! > 1 ? 's' : ''}',
                    color: theme.primaryColorDark),
              ]),
              CustomDropdown(
                icon: Icons.supervisor_account,
                label: '¿Fue supervisado?',
                items: const [
                  {'value': true, 'label': 'Sí'},
                  {'value': false, 'label': 'No'}
                ],
                value: _wasSupervised,
                onChanged: (b) => _onChanged('was_supervised', b),
              ),
              CustomTextField(
                controller: callController,
                label: 'Número de llamados de atención',
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }
}
