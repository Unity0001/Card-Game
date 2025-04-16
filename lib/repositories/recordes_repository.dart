import 'package:cardgame/constants.dart';
import 'package:cardgame/models/game_play.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:mobx/mobx.dart';

part 'recordes_repository.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;

abstract class RecordesRepositoryBase with Store {
  late final Box _recordes;
  late final GamePlay gamePlay;

  @observable
  Map recordesPokemon = {};
  @observable
  Map recordesNormal = {};

  RecordesRepositoryBase() {
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await loadRecordes();
  }

  _initDatabase() async {
    _recordes = await Hive.openBox('gameRecordes');
  }

  @action
  loadRecordes() {
    recordesNormal = _recordes.get(Modo.normal.toString()) ?? {};
    recordesPokemon = _recordes.get(Modo.pokemon.toString()) ?? {};
  }

  updateRecordes({required GamePlay gamePlay, required int score}) {
    final key = gamePlay.modo.toString();

    if (gamePlay.modo == Modo.normal &&
        (recordesNormal[gamePlay.nivel] == null ||
            score < recordesNormal[gamePlay.nivel])) {
      recordesNormal[gamePlay.nivel] = score;
      _recordes.put(key, recordesNormal);
    } else if (gamePlay.modo == Modo.pokemon &&
        (recordesPokemon[gamePlay.nivel] == null ||
            score > recordesPokemon[gamePlay.nivel])) {
      recordesPokemon[gamePlay.nivel] = score;
      _recordes.put(key, recordesPokemon);
    }
  }
}
