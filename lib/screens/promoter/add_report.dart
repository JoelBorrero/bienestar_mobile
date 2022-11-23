import 'package:flutter/material.dart';

import 'package:bienestar_mobile/backend/models/response.dart';
import 'package:bienestar_mobile/backend/models/user.dart';
import 'package:bienestar_mobile/backend/models/zone.dart';
import 'package:bienestar_mobile/backend/services/api.dart';
import 'package:bienestar_mobile/utils/validators.dart';
import 'package:bienestar_mobile/widgets/atoms/text_components.dart';
import 'package:bienestar_mobile/widgets/components/custom_dropdown.dart';
import 'package:bienestar_mobile/widgets/components/custom_text_field.dart';
import 'package:bienestar_mobile/widgets/components/date_picker.dart';
import 'package:bienestar_mobile/widgets/components/gradient_button.dart';
import 'package:provider/provider.dart';

bool _dataIsLoaded = false;
final _formKey = GlobalKey<FormState>();
bool _hasInteractedByUser = false;
List _hours = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
DateTime _date = DateTime.now();
int? _startHour = TimeOfDay.now().hour,
    _endHour,
    _supervisorId = 0,
    _wakeUpCalls,
    _peopleCalled,
    _zoneId;
bool? _wasSupervised;
String? _notes;
List<User> _supervisors = [];
List<Zone> _zones = [];
final TextEditingController _wakeUpCallsController = TextEditingController(),
    _peopleCalledController = TextEditingController(),
    _notesController = TextEditingController();

Map<String, Object?> _answers = {
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
      if (['date', 'start_hour', 'end_hour'].contains(key)) {
        String dateString = '${_date.year}-${_date.month}-${_date.day}';
        _answers['start_date'] = '$dateString $_startHour:30:00';
        _answers['end_date'] = '$dateString $_endHour:30:00';
      } else {
        _answers[key] = (key == 'supervisor' && value == 0) ? null : value;
      }
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

  void initialLoad(API api) async {
    final queryParameters = {
      'role': 'supervisor',
    };
    APIResponse response = await api.get('/accounts/', query: queryParameters);
    if (response.statusCode == 200) {
      setState(() {
        _supervisors = response.results!.map((u) => User.fromJson(u)).toList();
      });
    }
    response = await api.get('/promoter/zone/', authenticate: true);
    if (response.statusCode == 200) {
      setState(() {
        _zones = response.results!.map((z) => Zone.fromJson(z)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context);
    if (!_dataIsLoaded) {
      initialLoad(api);
      _dataIsLoaded = true;
    }
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
      body: RefreshIndicator(
        onRefresh: () async {
          initialLoad(api);
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
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
              CustomDropdown(
                icon: Icons.supervisor_account,
                label: '¿Fue supervisado?',
                items: const [
                  {'value': true, 'label': 'Sí'},
                  {'value': false, 'label': 'No'}
                ],
                value: _wasSupervised,
                onChanged: (b) => _onChanged('was_supervised', b),
                validator: ((value) => isNotEmpty(
                    value, 'Por favor indique si fue o no supervisado')),
                hasInteractedByUser: _hasInteractedByUser,
              ),
              CustomDropdown(
                  icon: Icons.supervisor_account,
                  label: 'Supervisor',
                  items: [
                    const {'value': 0, 'label': '-'},
                    ..._supervisors
                        .map((s) => {'value': s.id, 'label': s.firstName})
                        .toList()
                  ],
                  value: _supervisorId,
                  onChanged: (s) => _onChanged('supervisor', s),
                  validator: ((value) => isNotEmpty(
                      value, 'Por favor indique quién lo supervisó')),
                  hasInteractedByUser: _hasInteractedByUser),
              CustomDropdown(
                  icon: Icons.business_outlined,
                  label: 'Zona',
                  items: _zones
                      .map((z) => {'value': z.id, 'label': z.name})
                      .toList(),
                  value: _zoneId,
                  onChanged: (z) => _onChanged('zone', z),
                  validator: ((value) => isNotEmpty(
                      value, 'Por favor ingrese la zona a reportar')),
                  hasInteractedByUser: _hasInteractedByUser),
              CustomTextField(
                controller: _peopleCalledController,
                label: 'Personas a las que le hizo llamado de atención',
                icon: Icons.groups,
                keyboardType: TextInputType.number,
                validator: ((value) => isNotEmpty(value,
                    'Por favor ingrese a cuántas personas les llamó la atención')),
              ),
              CustomTextField(
                controller: _wakeUpCallsController,
                label: 'Número de llamados de atención',
                icon: Icons.warning_amber_rounded,
                keyboardType: TextInputType.number,
                validator: ((value) => isNotEmpty(value,
                    'Por favor indique a cuántas personas les hizo llamado de atención')),
              ),
              CustomTextField(
                controller: _notesController,
                label: 'Notas',
                icon: Icons.note_alt_outlined,
              ),
              GradientButton(
                text: 'Enviar',
                onPressed: () async {
                  if (!_hasInteractedByUser) {
                    setState(() {
                      _hasInteractedByUser = true;
                    });
                  }
                  if (_formKey.currentState!.validate()) {
                    APIResponse response = await api.post(
                      '/promoter/record/',
                      authenticate: true,
                      body: _answers,
                    );
                    print(response.raw);
                    if (response.statusCode == 201) {
                      // Reset the answers
                      // _wasSupervised = null;
                      // _supervisorId = null;
                      // _wakeUpCalls = null;
                      // _peopleCalled = null;
                      // _notes = null;
                      // _zoneId = null;
                      // ignore: use_build_context_synchronously
                      // show toast
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: textMedium('Reporte enviado'),
                          backgroundColor: theme.primaryColor,
                        ),
                      );
                      // Navigator.pop(context);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
