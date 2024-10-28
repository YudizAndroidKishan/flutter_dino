import 'package:flame/components.dart';
import 'package:flutter_dino/components/obstacle/base_obstacle.dart';

class BigCactus extends Obstacle {
  BigCactus({required Function onRemoveCallback})
      : super(
          spritePosition: Vector2(652, 2),
          spriteSize: Vector2(50, 100),
          size: Vector2(25, 50),
          onRemoveCallback: onRemoveCallback,
        );
}
