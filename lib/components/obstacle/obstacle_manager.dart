import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_dino/components/obstacle/base_obstacle.dart';
import 'package:flutter_dino/components/obstacle/big_cactus.dart';
import 'package:flutter_dino/components/obstacle/small_cactus.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class ObstacleManager extends Component with HasGameRef<DinoGame> {
  final Random _random = Random();
  double _timeSinceLastSpawn = 0;
  double _minSpawnTime = 1.5;
  final double _maxSpawnTime = 3.0;
  late double _nextSpawnTime;
  int _obstacleCount = 0;
  final int _maxObstacles = 3;

  ObstacleManager() {
    _nextSpawnTime = _minSpawnTime;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.isPlaying) {
      _timeSinceLastSpawn += dt;
      if (_timeSinceLastSpawn >= _nextSpawnTime &&
          _obstacleCount < _maxObstacles) {
        _spawnObstacle();
        _timeSinceLastSpawn = 0;
        _nextSpawnTime = _minSpawnTime +
            _random.nextDouble() * (_maxSpawnTime - _minSpawnTime);

        // Gradually decrease minimum spawn time
        _minSpawnTime = max(0.8, _minSpawnTime - 0.05);
      }
    }
  }

  void _spawnObstacle() {
    final obstacle = _random.nextBool()
        ? SmallCactus(onRemoveCallback: _onObstacleRemoved)
        : BigCactus(onRemoveCallback: _onObstacleRemoved);
    gameRef.add(obstacle);
    _obstacleCount++;
  }

  void _onObstacleRemoved() {
    _obstacleCount--;
  }

  void reset() {
    _timeSinceLastSpawn = 0;
    _minSpawnTime = 1.5;
    _nextSpawnTime = _minSpawnTime;
    _obstacleCount = 0;
    gameRef.children.whereType<Obstacle>().forEach((obstacle) {
      obstacle.removeFromParent();
    });
  }
}
