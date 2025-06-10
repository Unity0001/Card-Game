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

  List<Widget> getRecordesList(Map recordes, double fontSize) {
    final List<Widget> widgets = [];

    recordes.forEach((nivel, score) {
      widgets.add(
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: fontSize * 0.4,
            horizontal: fontSize * 0.5,
          ),
          title: Text('Nível $nivel', style: TextStyle(fontSize: fontSize)),
          trailing: Text(
            score.toString(),
            style: TextStyle(fontSize: fontSize),
          ),
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
        Padding(
          padding: EdgeInsets.only(top: fontSize * 0.7),
          child: Center(
            child: Text(
              'AINDA NÃO HÁ RECORDES!',
              style: TextStyle(fontSize: fontSize * 0.7),
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

    final media = MediaQuery.of(context);
    final largura = media.size.width;

    final baseFontSize = (largura / 15).clamp(16, 35).toDouble();

    return Scaffold(
      appBar: AppBar(title: const Text('Recordes')),
      body: Padding(
        padding: EdgeInsets.all(largura * 0.03),
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
                  SizedBox(height: baseFontSize * 0.7),
                  Center(
                    child: Text(
                      'Modo ${getModo()}',
                      style: TextStyle(
                        fontSize: (baseFontSize * 1.4),
                        color: PokemonTheme.color,
                      ),
                    ),
                  ),
                  SizedBox(height: baseFontSize * 0.7),
                  ...getRecordesList(recordes, baseFontSize * 0.7),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
