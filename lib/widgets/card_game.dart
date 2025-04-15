import 'dart:math';
import 'package:cardgame/constants.dart';
import 'package:cardgame/controllers/game_controller.dart';
import 'package:cardgame/models/game_options.dart';
import 'package:cardgame/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardGame extends StatefulWidget {
  final Modo modo;
  final GameOptions gameOptions;

  const CardGame({super.key, required this.modo, required this.gameOptions});

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  final Map<String, String> imagens = {
    'abra': 'images/abra.png',
    'bulbasaur': 'images/bulbasaur.png',
    'charmander': 'images/charmander.png',
    'farfetch': 'images/farfetch.png',
    'growlithe': 'images/growlithe.png',
    'oddish': 'images/oddish.png',
    'paras': 'images/paras.png',
    'poliwag': 'images/poliwag.png',
    'ponyta': 'images/ponyta.png',
    'psyduck': 'images/psyduck.png',
    'sandshrew': 'images/sandshrew.png',
    'squirtle': 'images/squirtle.png',
    'vulpix': 'images/vulpix.png',
    'pikachu': 'images/pikachu.png',
  };

  final List<String> nomes = [
    'abra',
    'bulbasaur',
    'charmander',
    'farfetch',
    'growlithe',
    'oddish',
    'paras',
    'poliwag',
    'ponyta',
    'psyduck',
    'sandshrew',
    'squirtle',
    'vulpix',
    'pikachu',
  ];

  AssetImage getImage(double angulo) {
    if (angulo > 0.5 * pi) {
      final int index = widget.gameOptions.opcao;
      final String nome =
          (index >= 0 && index < nomes.length) ? nomes[index] : 'pikachu';
      final String? caminho = imagens[nome];
      return AssetImage(caminho ?? 'images/pikachu.png');
    } else {
      return widget.modo == Modo.normal
          ? const AssetImage('images/card_normal.png')
          : const AssetImage('images/poke_card.jpg');
    }
  }

  flipCard() {
    final game = context.read<GameController>();

    if (!animation.isAnimating &&
        !widget.gameOptions.matched &&
        !widget.gameOptions.selected &&
        !game.jogadaCompleta) {
      animation.forward();
      game.escolher(widget.gameOptions, resetCard);
    }
  }

  resetCard() {
    animation.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, _) {
        final angulo = animation.value * pi;
        final transform =
            Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(angulo);

        return GestureDetector(
          onTap: () => flipCard(),
          child: Transform(
            transform: transform,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      widget.modo == Modo.normal
                          ? Colors.white
                          : PokemonTheme.color,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: getImage(angulo),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
