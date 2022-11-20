import 'package:flutter/material.dart';

import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/date_picker.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';

DateTime _date = DateTime.now();
List _hours = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
int? _startHour, _endHour;

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  @override
  Widget build(BuildContext context) {
    _startHour ??= TimeOfDay.now().hour;
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
                updateDate: (DateTime date) {
                  setState(() {
                    _date = date;
                  });
                },
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
                  onChanged: (h) {
                    setState(() {
                      _startHour = h as int;
                    });
                  },
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
                  onChanged: (h) {
                    setState(() {
                      _endHour = h as int;
                    });
                  },
                ),
                textMedium('${_endHour! - _startHour!} hora${_endHour! - _startHour! > 1 ? 's' : ''}',
                    color: theme.primaryColorDark),
              ]),
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
