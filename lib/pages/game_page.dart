import 'package:cardgame/constants.dart';
import 'package:cardgame/controllers/game_controller.dart';
import 'package:cardgame/game_settings.dart';
import 'package:cardgame/models/game_options.dart';
import 'package:cardgame/models/game_play.dart';
import 'package:cardgame/widgets/card_game.dart';
import 'package:cardgame/widgets/feedback_game.dart';
import 'package:cardgame/widgets/game_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final GamePlay gamePlay;

  const GamePage({super.key, required this.gamePlay});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GameScore(modo: gamePlay.modo),
      ),

      body: Observer(
        builder: (_) {
          if (controller.venceu) {
            return const FeedbackGame(resultado: Resultado.aprovado);
          } else if (controller.perdeu) {
            return const FeedbackGame(resultado: Resultado.reprovado);
          } else {
            return Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: GameSettings.gameBoardAxisCount(gamePlay.nivel),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(24),
                children:
                    controller.gameCards
                        .map(
                          (GameOptions go) =>
                              CardGame(modo: gamePlay.modo, gameOptions: go),
                        )
                        .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
