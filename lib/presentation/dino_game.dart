import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino/components/cloud/cloud_manager.dart';
import 'package:flutter_dino/components/dino.dart';
import 'package:flutter_dino/components/ground.dart';
import 'package:flutter_dino/components/obstacle/obstacle_manager.dart';
import 'package:flutter_dino/components/retry.dart';

class DinoGame extends FlameGame with TapDetector, HasCollisionDetection {
  static late DinoGame instance; // Add this line to hold the current instance
  final ThemeData theme;

  final Vector2 screenSize;

  DinoGame({
    required this.screenSize,
    required this.theme,
  }) : super(
            camera: CameraComponent.withFixedResolution(
          width: screenSize.x,
          height: screenSize.y,
        )) {
    instance = this;
  }

  @override
  Images images = Images(prefix: 'packages/flutter_dino/assets/images/');

  late Dino dino;
  late Retry retry;
  late ObstacleManager obstacleManager;
  late CloudManager cloudManager;
  late TextComponent scoreText;
  late TextComponent noInternetText;
  // late TextComponent gameOverText;
  double gameSpeed = 200;
  num score = 0;
  bool isPlaying = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add ground
    final ground = Ground();
    await add(ground);

    // Add dino
    dino = Dino();
    await add(dino);

    // Initialize and add obstacle manager
    obstacleManager = ObstacleManager();
    await add(obstacleManager);

    // Add cloud manager
    cloudManager = CloudManager();
    await add(cloudManager);

    // Add score text
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x - 10, 10),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: theme.textTheme.bodySmall,
      ),
    );
    await add(scoreText);

    noInternetText = TextComponent(
      text: 'No Internet',
      position: Vector2(size.x / 2, size.y + 100),
      anchor: Anchor.bottomCenter,
      textRenderer: TextPaint(
        style: theme.textTheme.titleLarge,
      ),
    );

    await add(noInternetText);

    // initialising retry game icon
    retry = Retry();
  }

  @override
  Color backgroundColor() {
    return theme.scaffoldBackgroundColor;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isPlaying) {
      score += dt;
      scoreText.text = 'Score: ${(score * 10).toInt()}';
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    onScreenTap();
  }

  void onScreenTap() {
    if (!isPlaying) {
      startGame();
    } else if (!dino.isDead) {
      dino.jump();
    }
  }

  void startGame() {
    isPlaying = true;
    score = 0;
    gameSpeed = 200;
    obstacleManager.reset();
    cloudManager.reset();
    dino.reset();
    retry.removeFromParent();
    noInternetText.removeFromParent();
  }

  void gameOver() {
    isPlaying = false;
    dino.die();
    add(retry);
  }
}
