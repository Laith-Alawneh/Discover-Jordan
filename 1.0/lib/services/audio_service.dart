import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService() : _player = AudioPlayer();

  final AudioPlayer _player;

  Future<void> playApplause() async {
    await _safePlay('audio/applause-sfx.mp3');
  }

  Future<void> playCorrectAnswer() async {
    await _safePlay('audio/correct-sfx.mp3');
  }

  Future<void> _safePlay(String path) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(path));
    } catch (_) {
      // Keep v1.0 resilient when assets are unavailable.
    }
  }
}
