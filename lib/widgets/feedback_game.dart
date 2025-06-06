import 'package:cardgame/constants.dart';
import 'package:cardgame/controllers/game_controller.dart';
import 'package:cardgame/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackGame extends StatelessWidget {
  final Resultado resultado;

  const FeedbackGame({super.key, required this.resultado});

  String getImageFileName() {
    if (resultado == Resultado.aprovado) {
      return 'approved.png';
    } else {
      return 'lost.png';
    }
  }

  String getResultadoText() {
    return resultado == Resultado.aprovado ? 'APROVADO' : 'REPROVADO';
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<GameController>();

    final String imageFileName = getImageFileName();
    final String imagePath = 'images/$imageFileName';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${getResultadoText()}!',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset(
              imagePath,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red, size: 100);
              },
            ),
          ),
          resultado == Resultado.reprovado
              ? StartButton(
                title: 'Tentar novamente',
                color: Colors.white,
                action: () {
                  controller.restartGame();
                  Navigator.of(context).pop();
                },
              )
              : StartButton(
                title: 'Próximo Nível',
                color: Colors.white,
                action: () {
                  controller.nextLevel();
                  Navigator.of(context).pop();
                },
              ),
        ],
      ),
    );
  }
}
