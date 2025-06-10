import 'package:cardgame/constants.dart';
import 'package:cardgame/pages/nivel_page.dart';
import 'package:cardgame/services/audio_player_service.dart';
import 'package:cardgame/theme.dart';
import 'package:cardgame/widgets/logo.dart';
import 'package:cardgame/widgets/recordes.dart';
import 'package:cardgame/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMusicOn = true;

  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NivelPage(modo: modo)),
    );
  }

  void _toggleMusic() {
    final musicService = Provider.of<MusicPlayerService>(
      context,
      listen: false,
    );

    if (isMusicOn) {
      musicService.pauseBackgroundMusic();
    } else {
      musicService.resumeBackgroundMusic();
    }

    setState(() {
      isMusicOn = !isMusicOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallHeight = screenHeight < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isMusicOn ? Icons.music_note : Icons.music_off),
            tooltip: isMusicOn ? 'Desligar música' : 'Ligar música',
            onPressed: _toggleMusic,
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final content = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Logo(),
                const SizedBox(height: 16),
                StartButton(
                  title: 'Modo Normal',
                  color: Colors.white,
                  action: () => selecionarNivel(Modo.normal, context),
                ),
                const SizedBox(height: 12),
                StartButton(
                  title: 'Modo Pokemon',
                  color: PokemonTheme.color,
                  action: () => selecionarNivel(Modo.pokemon, context),
                ),
                const SizedBox(height: 32),
                const Recordes(),
              ],
            );

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                    minHeight: isSmallHeight ? screenHeight : 0,
                  ),
                  child: content,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
