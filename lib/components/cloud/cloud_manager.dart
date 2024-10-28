import 'package:flame/components.dart';
import 'package:flutter_dino/components/cloud/cloud.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class CloudManager extends Component with HasGameRef<DinoGame> {
  double _timeSinceLastSpawn = 0;
  final double _spawnInterval = 2.0;
  final int _maxClouds = 2;
  final List<Cloud> _clouds = [];

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.isPlaying) {
      _timeSinceLastSpawn += dt;
      if (_timeSinceLastSpawn >= _spawnInterval &&
          _clouds.length < _maxClouds) {
        _spawnCloud();
        _timeSinceLastSpawn = 0;
      }
    }
    _clouds.removeWhere((cloud) => cloud.isRemoved);
  }

  void _spawnCloud() {
    final cloud = Cloud(scrollSpeed: gameRef.gameSpeed * 0.3);
    gameRef.add(cloud);
    _clouds.add(cloud);
  }

  void reset() {
    _timeSinceLastSpawn = 0;
    for (final cloud in _clouds) {
      cloud.removeFromParent();
    }
    _clouds.clear();
  }
}
