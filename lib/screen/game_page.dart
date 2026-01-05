import 'package:annike_game/screen/snake_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'flappybird_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _FlappyBirdGameState();
}

class _FlappyBirdGameState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(child: SnakeGame()),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: const GameWidget.controlled(
                    gameFactory: FlappyBirdGame.new,
                  ),
                ),
              ),
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
    );
  }
}
