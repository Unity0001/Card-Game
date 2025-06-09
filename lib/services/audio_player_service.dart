import 'package:audioplayers/audioplayers.dart';

class MusicPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  MusicPlayerService() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.setVolume(0.3);
  }

  Future<void> playBackgroundMusic(String assetPath) async {
    if (!_isPlaying) {
      try {
        await _audioPlayer.play(AssetSource(assetPath));
        _isPlaying = true;
      } catch (e) {
        // ignore: avoid_print
        print('Erro ao tocar música: $e');
      }
    }
  }

  Future<void> stopBackgroundMusic() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
    }
  }

  Future<void> pauseBackgroundMusic() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
    }
  }

  Future<void> resumeBackgroundMusic() async {
    if (!_isPlaying) {
      try {
        await _audioPlayer.resume();
        _isPlaying = true;
      } catch (e) {
        print('Erro ao retomar música: $e');
      }
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
