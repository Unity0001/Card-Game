import 'package:cardgame/constants.dart';
import 'package:cardgame/game_settings.dart';
import 'package:cardgame/models/game_options.dart';
import 'package:cardgame/models/game_play.dart';
import 'package:cardgame/repositories/recordes_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:mobx/mobx.dart';

part 'game_controller.g.dart';

class GameController = GameControllerBase with _$GameController;

abstract class GameControllerBase with Store {
  @observable
  List<GameOptions> gameCards = [];
  @observable
  int score = 0;
  @observable
  bool venceu = false;
  @observable
  bool perdeu = false;

  late GamePlay _gamePlay;
  List<GameOptions> _escolha = [];
  List<Function> _escolhaCallback = [];
  int _acertos = 0;
  int _numPares = 0;
  RecordesRepository recordesRepository;

  @computed
  bool get jogadaCompleta => (_escolha.length == 2);

  GameControllerBase({required this.recordesRepository}) {
    reaction((_) => venceu == true, (bool ganhou) {
      if (ganhou) {
        recordesRepository.updateRecordes(gamePlay: _gamePlay, score: score);
      }
    });
  }

  startGame({required GamePlay gamePlay}) {
    _gamePlay = gamePlay;
    _acertos = 0;
    _numPares = (_gamePlay.nivel / 2).round();
    venceu = false;
    perdeu = false;
    _resetScore();
    _generateCards();
  }

  _resetScore() {
    _gamePlay.modo == Modo.pokemon ? score = _gamePlay.nivel : score = 0;
  }

  _generateCards() {
    List<int> cardOptions = GameSettings.cardOptions.sublist(0)..shuffle();
    cardOptions = cardOptions.sublist(0, _numPares);
    gameCards =
        [...cardOptions, ...cardOptions]
            .map(
              (opcao) =>
                  GameOptions(matched: false, opcao: opcao, selected: false),
            )
            .toList();
    gameCards.shuffle();
  }

  escolher(GameOptions opcao, Function resetCard) async {
    opcao.selected = true;
    _escolha.add(opcao);
    _escolhaCallback.add(resetCard);
    await _compararEscolhas();
  }

  _compararEscolhas() async {
    if (jogadaCompleta) {
      bool acertou = false;
      if (_escolha[0].opcao == _escolha[1].opcao) {
        acertou = true;
        _acertos++;
        _escolha[0].matched = true;
        _escolha[1].matched = true;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          for (var i in [0, 1]) {
            _escolha[i].selected = false;
            _escolhaCallback[i]();
          }
        });
      }

      _resetJogada();
      _updateScore(acertou: acertou);
      _checkGameResult();
    }
  }

  _checkGameResult() async {
    bool allMatched = _acertos == _numPares;
    if (_gamePlay.modo == Modo.normal) {
      await _checkGameResultModoNormal(allMatched);
    } else {
      await _checkGameResultModoPokemon(allMatched);
    }
  }

  _checkGameResultModoNormal(bool allMatched) async {
    await Future.delayed(const Duration(seconds: 1), () => venceu = allMatched);
  }

  _checkGameResultModoPokemon(bool allMatched) async {
    await Future.delayed(const Duration(seconds: 1));

    if (allMatched) {
      venceu = true;
      perdeu = false;
    } else if (_chancesAcabaram()) {
      venceu = false;
      perdeu = true;
    }
  }

  _chancesAcabaram() {
    return score <= 0;
  }

  _resetJogada() {
    _escolha = [];
    _escolhaCallback = [];
  }

  _updateScore({required bool acertou}) {
    if (_gamePlay.modo == Modo.normal) {
      score++;
    } else {
      if (!acertou && score > 0) {
        score--;
      }
    }
  }

  restartGame() {
    startGame(gamePlay: _gamePlay);
  }

  nextLevel() {
    int nivelIndex = 0;

    if (_gamePlay.nivel != GameSettings.niveis.last) {
      nivelIndex = GameSettings.niveis.indexOf(_gamePlay.nivel) + 1;
    }

    _gamePlay.nivel = GameSettings.niveis[nivelIndex];
    startGame(gamePlay: _gamePlay);
  }
}
