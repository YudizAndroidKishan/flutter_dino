import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino/presentation/dino_game.dart';

class DinoProvider extends StatelessWidget {
  const DinoProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DinoGame.instance.onScreenTap();
      },
      child: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) {
              // Get the device width using MediaQuery
              double deviceWidth = MediaQuery.sizeOf(context).width;
              double deviceHeight = MediaQuery.sizeOf(context).height;
              return SizedBox(
                height:
                    deviceHeight * 0.3, // You can adjust the height if needed
                child: GameWidget(
                  game: DinoGame(
                    screenSize: Vector2(
                      deviceWidth,
                      deviceHeight * 0.3,
                    ), // Using device width
                    theme: Theme.of(context),
                  ),
                  loadingBuilder: (_) => const SizedBox(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
