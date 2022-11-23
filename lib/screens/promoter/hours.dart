import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bienestar_mobile/backend/services/api.dart';
import 'package:bienestar_mobile/screens/promoter/add_report.dart';
import 'package:bienestar_mobile/widgets/atoms/text_components.dart';
import 'package:bienestar_mobile/widgets/components/drawer.dart';

class Hours extends StatelessWidget {
  final MyDrawer drawer;
  const Hours(this.drawer, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // final api = Provider.of<API>(context);
    // User user = api.user!;
    return Scaffold(
        appBar: AppBar(
          title: textH1('Mis horas', dark: false),
          backgroundColor: theme.primaryColor,
        ),
        body: FutureBuilder(
          future: Provider.of<API>(context, listen: false).getHours(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return RefreshIndicator(
                  onRefresh: () async {},
                  child: snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(snapshot.data[index].date),
                                subtitle:
                                    Text(snapshot.data[index].hours.toString()),
                              ),
                            );
                          },
                        )
                      : const Center(child: Text('No hay horas registradas')));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddReport(),
            ),
          ),
          backgroundColor: theme.primaryColor,
          child: const Icon(Icons.post_add),
        ),
        drawer: drawer);
  }
}
