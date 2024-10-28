import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class Cloud extends SpriteComponent with HasGameRef<DinoGame> {
  static const double spriteWidth = 92;
  static const double spriteHeight = 28;
  final double scrollSpeed;
  final Random _random = Random();

  Cloud({required this.scrollSpeed})
      : super(size: Vector2(spriteWidth, spriteHeight));

  @override
  Future<void> onLoad() async {
    final spriteImage = await gameRef.images.load('sprite.png');
    sprite = Sprite(
      spriteImage,
      srcPosition: Vector2(166, 2),
      srcSize: Vector2(spriteWidth, spriteHeight),
    );
    priority = 0;

    // Position the cloud just above the Dino
    double dinoHeight = gameRef.dino.size.y;
    double groundHeight = 26; // Assuming the ground height is 26 pixels
    double availableHeight = 250 - groundHeight - dinoHeight - 40;

    position = Vector2(
      gameRef.size.x + size.x,
      gameRef.size.y -
          groundHeight -
          dinoHeight -
          30 -
          _random.nextDouble() * availableHeight,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.isPlaying) {
      x -= scrollSpeed * dt;
      if (x < -size.x) {
        removeFromParent();
      }
    }
  }
}
