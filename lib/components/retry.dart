import 'package:flame/components.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class Retry extends SpriteComponent with HasGameRef<DinoGame> {
  static const double spriteHeight = 64;
  static const double spriteWidth = 72;

  Retry() : super(size: Vector2(spriteWidth, spriteHeight));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    load();
  }

  Future<void> load() async {
    final spriteImage = await gameRef.images.load('sprite.png');
    sprite = Sprite(
      spriteImage,
      srcSize: Vector2(spriteWidth, spriteHeight),
      srcPosition: Vector2(0, 0),
    );

    priority = 1;

    position = Vector2(
      (gameRef.screenSize.x / 2) - (spriteWidth / 2),
      (gameRef.screenSize.y / 2) - (spriteHeight / 2),
    );
  }
}
