import 'package:cardgame/theme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Image.asset(
            'images/pikachu.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RichText(
            text: TextSpan(
              text: 'Pokemon',
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 40),
              children: const [
                TextSpan(
                  text: 'Memory',
                  style: TextStyle(color: PokemonTheme.color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
