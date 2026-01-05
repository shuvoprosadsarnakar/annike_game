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
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameInputCubit(),
      child: Builder(
        builder: (context) {
          // Use a FocusNode to capture keyboard events at the screen level
          final focusNode = FocusNode();
          // Request focus immediately so we catch events
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (focusNode.canRequestFocus) {
              focusNode.requestFocus();
            }
          });

          return Scaffold(
            body: KeyboardListener(
              focusNode: focusNode,
              autofocus: true,
              onKeyEvent: (event) {
                if (event is KeyDownEvent) {
                  final cubit = context.read<GameInputCubit>();
                  if (event.logicalKey == LogicalKeyboardKey.space) {
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
                  } else if (event.logicalKey ==
                          LogicalKeyboardKey.arrowRight ||
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
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: GameWidget.controlled(
                            gameFactory: () =>
                                FlappyBirdGame(context.read<GameInputCubit>()),
                          ),
                        ),
                      ),
                      Expanded(child: SnakeGame()),
                      // Expanded(child: Container(color: Colors.green)),
                    ],
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
        },
      ),
    );
  }
}
