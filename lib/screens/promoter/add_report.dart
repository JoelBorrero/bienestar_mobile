import 'package:bienestar_mobile/utils/validators.dart';
import 'package:flutter/material.dart';

import 'package:bienestar_mobile/backend/models/response.dart';
import 'package:bienestar_mobile/backend/models/user.dart';
import 'package:bienestar_mobile/backend/services/api.dart';
import 'package:bienestar_mobile/widgets/components/text_components.dart';
import 'package:bienestar_mobile/widgets/modules/custom_dropdown.dart';
import 'package:bienestar_mobile/widgets/modules/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/modules/date_picker.dart';
import 'package:bienestar_mobile/widgets/modules/gradient_button.dart';

final _formKey = GlobalKey<FormState>();
bool _hasInteractedByUser = false;
List _hours = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
DateTime _date = DateTime.now();
int? _startHour = TimeOfDay.now().hour,
    _endHour,
    _supervisorId,
    _wakeUpCalls,
    _peopleCalled,
    _zoneId;
bool? _wasSupervised;
String? _notes;
List<User> _supervisors = [];
final TextEditingController _wakeUpCallsController = TextEditingController(),
    _peopleCalledController = TextEditingController(),
    _notesController = TextEditingController();

Map<String, Object?> _answers = {
  'date': _date,
  'start_hour': _startHour,
  'end_hour': _endHour,
  'was_supervised': _wasSupervised,
  'supervisor': _supervisorId,
  'wake_up_calls': _wakeUpCalls,
  'people_called': _peopleCalled,
  'promoter_notes': _notes,
  'zone': _zoneId,
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
        case 'supervisor':
          _supervisorId = value;
          break;
        case 'wake_up_calls':
          _wakeUpCalls = value;
          break;
        case 'people_called':
          _peopleCalled = value;
          break;
        case 'notes':
          _notes = value;
          break;
        case 'zone':
          _zoneId = value;
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final queryParameters = {
      'role': 'supervisor',
    };
    Future<APIResponse> response = API.get('/accounts/', queryParameters);
    response.then((res) {
      if (res.statusCode == 200) {
        setState(() {
          _supervisors = res.results!.map((u) => User.fromJson(u)).toList();
        });
      }
    });
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
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: textH1('Agregar reporte', dark: false),
        backgroundColor: theme.primaryColor,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              DatePicker(
                date: _date,
                updateDate: (date) => _onChanged('date', date),
                validator: ((value) =>
                    isNotEmpty(value, 'Por favor ingrese una fecha')),
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              CustomDropdown(
                  icon: Icons.supervisor_account,
                  label: '¿Fue supervisado?',
                  items: const [
                    {'value': true, 'label': 'Sí'},
                    {'value': false, 'label': 'No'}
                  ],
                  value: _wasSupervised,
                  onChanged: (b) => _onChanged('was_supervised', b),
                  validator: ((value) =>
                      isNotEmpty(value, 'Por favor ingrese una')),
                  hasInteractedByUser: _hasInteractedByUser),
              // CustomDropdown(
              //   icon: Icons.supervisor_account,
              //   label: 'Supervisor',
              //   items: _supervisors.isEmpty
              //       ? []
              //       : _supervisors
              //           .map((s) => {'value': s.id, 'label': s.firstName})
              //           .toList(),
              //   value: _supervisorId,
              //   onChanged: (s) => _onChanged('supervisor', s),
              //   validator: ((value) => isNotEmpty(value, 'Por favor ingrese una nota')),
              // ),
              CustomTextField(
                controller: _peopleCalledController,
                label: 'Personas a las que le hizo llamado de atención',
                icon: Icons.groups,
                keyboardType: TextInputType.number,
                validator: ((value) => isNotEmpty(value,
                    'Por favor ingrese a cuántas personas les llamó la atención')),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _wakeUpCallsController,
                label: 'Número de llamados de atención',
                icon: Icons.warning_amber_rounded,
                keyboardType: TextInputType.number,
                validator: ((value) => isNotEmpty(value,
                    'Por favor indique a cuántas personas les hizo llamado de atención')),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _notesController,
                label: 'Notas',
                icon: Icons.note_alt_outlined,
              ),
              const SizedBox(height: 20),
              GradientButton(
                  text: 'Enviar',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _hasInteractedByUser = true;
                      });
                      // Reset the answers
                      _wasSupervised = null;
                      _supervisorId = null;
                      _wakeUpCalls = null;
                      _peopleCalled = null;
                      _notes = null;
                      _zoneId = null;

                      Navigator.pop(context);
                    }
                  })
            ],
          )),
    );
  }
}
