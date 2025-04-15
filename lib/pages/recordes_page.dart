import 'package:cardgame/constants.dart';
import 'package:cardgame/repositories/recordes_repository.dart';
import 'package:cardgame/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class RecordesPage extends StatelessWidget {
  final Modo modo;

  const RecordesPage({super.key, required this.modo});

  getModo() {
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
      widgets.add(const Center(child: Text('AINDA NÃO HÁ RECORDES!')));
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
          builder:
              (context) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 36, bottom: 24),
                    child: Center(
                      child: Text(
                        'Modo ${getModo()}',
                        style: const TextStyle(
                          fontSize: 28,
                          color: PokemonTheme.color,
                        ),
                      ),
                    ),
                  ),
                  ...getRecordesList(
                    modo == Modo.normal
                        ? repository.recordesNormal
                        : repository.recordesPokemon,
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
