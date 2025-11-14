import 'package:annike_game/screen/snake/snake_game.dart';
import 'package:flutter/material.dart';

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
              // Expanded(
              //   child: const GameWidget.controlled(
              //     gameFactory: FlappyBirdGame.new,
              //   ),
              // ),
              Expanded(child: Container(color: Colors.green)),
              Expanded(child: SnakeGame()),
            ],
          ),
          Positioned(
            left: 16,
            top: 16,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
