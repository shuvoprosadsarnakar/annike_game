import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<StatefulWidget> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  final int squaresPerRow = 25;
  final int squaresPerCol = 25;
  final fontStyle = TextStyle(color: Colors.white, fontSize: 20);
  final randomGen = Random();

  var snake = [
    [0, 1],
    [0, 0],
  ];
  var food = [0, 2];
  Direction direction = Direction.up;
  var isPlaying = false;

  void startGame() {
    const duration = Duration(milliseconds: 300);

    snake = [
      // Snake head
      [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()],
    ];

    snake.add([snake.first[0], snake.first[1] + 1]); // Snake body

    createFood();

    isPlaying = true;
    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;

        case Direction.down:
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;

        case Direction.left:
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;

        case Direction.right:
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;
      }

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      } else {
        createFood();
      }
    });
  }

  void createFood() {
    food = [randomGen.nextInt(squaresPerRow), randomGen.nextInt(squaresPerCol)];
  }

  bool checkGameOver() {
    if (!isPlaying ||
        snake.first[1] < 0 ||
        snake.first[1] >= squaresPerCol ||
        snake.first[0] < 0 ||
        snake.first[0] > squaresPerRow) {
      return true;
    }

    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    isPlaying = false;
  }

  @override
  void initState() {
    startGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF343434),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Score: ${snake.length - 2}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != Direction.up && details.delta.dy > 0) {
                    direction = Direction.down;
                  } else if (direction != Direction.down &&
                      details.delta.dy < 0) {
                    direction = Direction.up;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != Direction.left && details.delta.dx > 0) {
                    direction = Direction.right;
                  } else if (direction != Direction.right &&
                      details.delta.dx < 0) {
                    direction = Direction.left;
                  }
                },
                child: AspectRatio(
                  // aspectRatio: squaresPerRow / (squaresPerCol + 5),
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: squaresPerRow,
                    ),
                    itemCount: squaresPerRow * squaresPerCol,
                    itemBuilder: (BuildContext context, int index) {
                      var color;
                      var x = index % squaresPerRow;
                      var y = (index / squaresPerRow).floor();

                      bool isSnakeBody = false;
                      for (var pos in snake) {
                        if (pos[0] == x && pos[1] == y) {
                          isSnakeBody = true;
                          break;
                        }
                      }

                      if (snake.first[0] == x && snake.first[1] == y) {
                        color = Colors.black;
                      } else if (isSnakeBody) {
                        color = Colors.black;
                      } else if (food[0] == x && food[1] == y) {
                        color = Colors.amber;
                      } else {
                        color = Colors.white60;
                      }

                      return Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            ElevatedButton(
              // color: isPlaying ? Colors.white : Colors.black,
              child: Text(
                isPlaying ? 'End' : 'Start',
                style: TextStyle(
                  color: isPlaying ? Colors.black87 : Colors.white,
                  fontSize: 24,
                ),
              ),
              onPressed: () async {
                if (isPlaying) {
                  isPlaying = false;
                } else {
                  startGame();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
