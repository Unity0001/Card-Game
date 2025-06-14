import 'package:cardgame/controllers/game_controller.dart';
import 'package:cardgame/pages/home_page.dart';
import 'package:cardgame/repositories/recordes_repository.dart';
import 'package:cardgame/services/audio_player_service.dart';
import 'package:cardgame/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  runApp(
    MultiProvider(
      providers: [
        Provider<RecordesRepository>(create: (_) => RecordesRepository()),
        ProxyProvider<RecordesRepository, GameController>(
          update: (_, repo, __) => GameController(recordesRepository: repo),
        ),
        Provider<MusicPlayerService>(
          create: (_) => MusicPlayerService(),
          dispose: (_, service) => service.dispose(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late MusicPlayerService _musicService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _musicService = Provider.of<MusicPlayerService>(context, listen: false);
      _musicService.playBackgroundMusic('audio/pokemusic.mp3');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final musicPlayer = Provider.of<MusicPlayerService>(context, listen: false);
    if (state == AppLifecycleState.paused) {
      musicPlayer.pauseBackgroundMusic();
    } else if (state == AppLifecycleState.resumed) {
      musicPlayer.resumeBackgroundMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Memory',
      debugShowCheckedModeBanner: false,
      theme: PokemonTheme.theme,
      home: const HomePage(),
    );
  }
}
