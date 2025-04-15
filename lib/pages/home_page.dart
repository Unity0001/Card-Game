import 'package:cardgame/constants.dart';
import 'package:cardgame/pages/nivel_page.dart';
import 'package:cardgame/theme.dart';
import 'package:cardgame/widgets/logo.dart';
import 'package:cardgame/widgets/recordes.dart';
import 'package:cardgame/widgets/start_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NivelPage(modo: modo)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            StartButton(
              title: 'Modo Normal',
              color: Colors.white,
              action: () => selecionarNivel(Modo.normal, context),
            ),
            StartButton(
              title: 'Modo Pokemon',
              color: PokemonTheme.color,
              action: () => selecionarNivel(Modo.pokemon, context),
            ),
            const SizedBox(height: 60),
            const Recordes(),
          ],
        ),
      ),
    );
  }
}
