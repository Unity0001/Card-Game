import 'package:cardgame/controllers/game_controller.dart';
import 'package:cardgame/pages/home_page.dart';
import 'package:cardgame/repositories/recordes_repository.dart';
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
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

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
