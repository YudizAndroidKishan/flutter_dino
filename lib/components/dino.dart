import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_dino/components/obstacle/base_obstacle.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class Dino extends SpriteAnimationComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  bool isJumping = false;
  bool isDead = false;
  double jumpSpeed = -500;
  double gravity = 1000;
  double velocityY = 0;
  double groundY = 0;
  late SpriteAnimation runAnimation;
  late SpriteAnimation deadAnimation;
  late SpriteAnimation steadyAnimation;

  Dino() : super(size: Vector2(44, 47));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteSheet = await gameRef.images.load('sprite.png');

    runAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.1,
        textureSize: Vector2(88, 94),
        texturePosition: Vector2(1514, 0),
      ),
    );

    deadAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.range(
        start: 2,
        end: 2,
        amount: 5,
        textureSize: Vector2(88, 94),
        texturePosition: Vector2(1514, 0),
        stepTimes: [0.1],
      ),
    );

    steadyAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.range(
        start: 2,
        end: 2,
        amount: 5,
        textureSize: Vector2(89, 90),
        texturePosition: Vector2(-103, 3),
        stepTimes: [0.1],
      ),
    );

    animation = steadyAnimation;

    groundY = gameRef.size.y - size.y - 5;
    position = Vector2(50, groundY);
    priority = 1;

    add(
      RectangleHitbox(size: Vector2(35, 20)),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.isPlaying && !isDead) {
      if (isJumping) {
        velocityY += gravity * dt;
        y += velocityY * dt;
        if (y >= groundY) {
          y = groundY;
          isJumping = false;
          velocityY = 0;
        }
      }
    }
  }

  void jump() {
    if (!isJumping && !isDead) {
      isJumping = true;
      velocityY = jumpSpeed;
    }
  }

  void die() {
    isDead = true;
    animation = deadAnimation;
  }

  void reset() {
    isDead = false;
    isJumping = false;
    y = groundY;
    velocityY = 0;
    animation = runAnimation;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Obstacle && !isDead) {
      gameRef.gameOver();
    }
  }
}
