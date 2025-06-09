import 'package:cardgame/constants.dart';
import 'package:cardgame/repositories/recordes_repository.dart';
import 'package:cardgame/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class RecordesPage extends StatelessWidget {
  final Modo modo;

  const RecordesPage({super.key, required this.modo});

  String getModo() {
    return modo == Modo.normal ? 'Normal' : 'Pokemon';
  }

  List<Widget> getRecordesList(Map recordes) {
    final List<Widget> widgets = [];

    recordes.forEach((nivel, score) {
      widgets.add(
        ListTile(
          title: Text('Nível $nivel'),
          trailing: Text(score.toString()),
          tileColor: Colors.grey[900],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      );
      widgets.add(const Divider(color: Colors.transparent));
    });

    if (widgets.isEmpty) {
      widgets.add(
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Center(
            child: Text(
              'AINDA NÃO HÁ RECORDES!',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<RecordesRepository>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Recordes')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Observer(
          builder: (context) {
            final recordes =
                modo == Modo.normal
                    ? repository.recordesNormal
                    : repository.recordesPokemon;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 36),
                  Center(
                    child: Text(
                      'Modo ${getModo()}',
                      style: const TextStyle(
                        fontSize: 28,
                        color: PokemonTheme.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...getRecordesList(recordes),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
