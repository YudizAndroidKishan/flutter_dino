import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class Ground extends PositionComponent with HasGameRef<DinoGame> {
  late Sprite sprite;
  final double spriteWidth = 2404;
  double scrollOffset = 0;

  Ground() : super(size: Vector2(2404, 26));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = await gameRef.images.load('sprite.png');
    sprite = Sprite(
      image,
      srcPosition: Vector2(2, 104),
      srcSize: Vector2(2404, 26),
    );
    position = Vector2(0, gameRef.size.y - 26);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.isPlaying) {
      scrollOffset += gameRef.gameSpeed * dt;
      scrollOffset %= spriteWidth;
    }
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(
      canvas,
      Rect.fromLTWH(-scrollOffset, 0, spriteWidth, size.y),
    );
    sprite.renderRect(
      canvas,
      Rect.fromLTWH(spriteWidth - scrollOffset, 0, spriteWidth, size.y),
    );
  }
}
