import 'package:flame/components.dart';
import 'package:flutter_dino/components/obstacle/base_obstacle.dart';

class SmallCactus extends Obstacle {
  SmallCactus({required Function onRemoveCallback})
      : super(
          spritePosition: Vector2(446, 2),
          spriteSize: Vector2(34, 70),
          size: Vector2(17, 35),
          onRemoveCallback: onRemoveCallback,
        );
}
