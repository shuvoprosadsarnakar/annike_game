import 'package:annike_game/screen/snake_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:annike_game/cubit/game_input_cubit.dart';

import 'flappybird_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _FlappyBirdGameState();
}

class _FlappyBirdGameState extends State<GamePage> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (focusNode.canRequestFocus) {
        focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardListener(
        focusNode: focusNode,
        autofocus: true,
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            final cubit = context.read<GameInputCubit>();
            if (event.logicalKey == LogicalKeyboardKey.space) {
              if (cubit.state is GameInputGameOver) {
                Navigator.of(context).pop();
                return;
              }
              cubit.jump();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
                event.logicalKey == LogicalKeyboardKey.keyW) {
              cubit.move(Direction.up);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
                event.logicalKey == LogicalKeyboardKey.keyS) {
              cubit.move(Direction.down);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
                event.logicalKey == LogicalKeyboardKey.keyA) {
              cubit.move(Direction.left);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
                event.logicalKey == LogicalKeyboardKey.keyD) {
              cubit.move(Direction.right);
            } else if (event.logicalKey == LogicalKeyboardKey.keyR) {
              cubit.restart();
            }
          }
        },
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: GameWidget.controlled(
                    gameFactory: () =>
                        FlappyBirdGame(context.read<GameInputCubit>()),
                  ),
                ),

                Expanded(child: SnakeGame()),
                // Expanded(child: Container(color: Colors.green)),
              ],
            ),

            BlocBuilder<GameInputCubit, GameInputState>(
              builder: (context, state) {
                if (state is GameInputGameOver) {
                  return Positioned.fill(
                    child: Image.asset(
                      "assets/flappybird/sprites/game-over2.jpeg",
                      fit: BoxFit.fill,
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            BlocBuilder<GameInputCubit, GameInputState>(
              builder: (context, state) {
                if (state is GameInputGameOver) {
                  final totalScore = state.flappyBirdScore + state.snakeScore;
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Text(
                        'SCORE : $totalScore',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 140,
                          fontFamily: "upheav",
                          letterSpacing: 8,
                          // shadows: [
                          //   Shadow(
                          //     blurRadius: 10.0,
                          //     color: Colors.black,
                          //     offset: Offset(3.0, 3.0),
                          //   ),
                          // ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 36,
                  padding: const EdgeInsets.all(12),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
