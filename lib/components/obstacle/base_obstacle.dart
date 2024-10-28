import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class Obstacle extends SpriteComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  final Vector2 spritePosition;
  final Vector2 spriteSize;
  final Function onRemoveCallback;

  Obstacle({
    required this.spritePosition,
    required this.spriteSize,
    required Vector2 size,
    required this.onRemoveCallback,
  }) : super(size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = await gameRef.images.load('sprite.png');
    sprite = Sprite(image, srcPosition: spritePosition, srcSize: spriteSize);
    position = Vector2(gameRef.size.x, gameRef.size.y - size.y - 5);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.isPlaying) {
      x -= gameRef.gameSpeed * dt;
      if (x < -size.x) {
        removeFromParent();
      }
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    onRemoveCallback();
  }
}
