import 'package:cardgame/constants.dart';
import 'package:cardgame/game_settings.dart';
import 'package:cardgame/models/game_play.dart';
import 'package:cardgame/widgets/card_nivel.dart';
import 'package:flutter/material.dart';

class NivelPage extends StatelessWidget {
  final Modo modo;

  const NivelPage({super.key, required this.modo});

  @override
  Widget build(BuildContext context) {
    final niveis =
        GameSettings.niveis
            .map((n) => CardNivel(gamePlay: GamePlay(modo: modo, nivel: n)))
            .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Nível do Jogo')),
      body: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          padding: const EdgeInsets.all(24),
          children: niveis,
        ),
      ),
    );
  }
}
