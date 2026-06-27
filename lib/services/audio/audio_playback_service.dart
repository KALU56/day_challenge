import 'package:audioplayers/audioplayers.dart';
import '../../core/constants/asset_paths.dart';

class AudioPlaybackService {
  final AudioPlayer _player = AudioPlayer();
  bool _isSoundEnabled = true;

  void setSoundEnabled(bool enabled) {
    _isSoundEnabled = enabled;
  }

  Future<void> playCoinEarned() async {
    if (!_isSoundEnabled) return;
    await _player.play(AssetSource(AssetPaths.soundCoinEarned.replaceFirst('assets/', '')));
  }

  Future<void> playPromiseBroken() async {
    if (!_isSoundEnabled) return;
    await _player.play(AssetSource(AssetPaths.soundPromiseBroken.replaceFirst('assets/', '')));
  }

  Future<void> playStreakMilestone() async {
    if (!_isSoundEnabled) return;
    await _player.play(AssetSource(AssetPaths.soundStreakMilestone.replaceFirst('assets/', '')));
  }

  void dispose() {
    _player.dispose();
  }
}
