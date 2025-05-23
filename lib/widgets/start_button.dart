import 'package:cardgame/theme.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function action;

  const StartButton({
    super.key,
    required this.title,
    required this.color,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: OutlinedButton(
        style: PokemonTheme.outlineButtonStyle(color: color),
        onPressed: () => action(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(title, style: const TextStyle(fontSize: 20))],
        ),
      ),
    );
  }
}
