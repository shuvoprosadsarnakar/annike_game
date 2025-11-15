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
  final int squaresPerRow = 20;
  final int squaresPerCol = 20;
  final fontStyle = TextStyle(color: Colors.white, fontSize: 20);
  final randomGen = Random();

  var snake = [
    [0, 1],
    [0, 0],
  ];
  var food = [0, 2];
  Direction direction = Direction.up;
  var isPlaying = false;
  Timer? _gameTimer;

  void startGame() {
    const duration = Duration(milliseconds: 300);

    snake = [
      // Snake head
      [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()],
    ];

    // Snake body - adding 3 segments to make total length 4
    snake.add([snake.first[0], snake.first[1] + 1]);
    snake.add([snake.first[0], snake.first[1] + 2]);
    snake.add([snake.first[0], snake.first[1] + 3]);

    createFood();
    direction = Direction.up;
    isPlaying = true;

    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  void moveSnake() {
    setState(() {
      int newX = snake.first[0];
      int newY = snake.first[1];

      switch (direction) {
        case Direction.up:
          newY = snake.first[1] - 1;
          break;
        case Direction.down:
          newY = snake.first[1] + 1;
          break;
        case Direction.left:
          newX = snake.first[0] - 1;
          break;
        case Direction.right:
          newX = snake.first[0] + 1;
          break;
      }

      // Phase through walls
      if (newX < 0) {
        newX = squaresPerRow - 1;
      } else if (newX >= squaresPerRow) {
        newX = 0;
      }

      if (newY < 0) {
        newY = squaresPerCol - 1;
      } else if (newY >= squaresPerCol) {
        newY = 0;
      }

      snake.insert(0, [newX, newY]);

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      } else {
        createFood();
      }
    });
  }

  void createFood() {
    // Make sure food doesn't spawn on snake
    var newFood;
    do {
      newFood = [
        randomGen.nextInt(squaresPerRow),
        randomGen.nextInt(squaresPerCol),
      ];
    } while (_isPositionOnSnake(newFood));

    food = newFood;
  }

  bool _isPositionOnSnake(List<int> position) {
    for (var segment in snake) {
      if (segment[0] == position[0] && segment[1] == position[1]) {
        return true;
      }
    }
    return false;
  }

  bool checkGameOver() {
    if (!isPlaying) {
      return true;
    }

    // Only check for self-collision, not wall collisions
    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    setState(() {
      isPlaying = false;
    });
    _gameTimer?.cancel();
  }

  void restartGame() {
    setState(() {
      isPlaying = false;
    });
    _gameTimer?.cancel();
    startGame();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF343434),
      child: Column(
        children: [
          // Score display
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: ${snake.length - 4}',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),

          // Game board
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: const EdgeInsets.all(20),
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
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                        color = Colors.black; // Snake head
                      } else if (isSnakeBody) {
                        color = Colors.black38; // Snake body
                      } else if (food[0] == x && food[1] == y) {
                        color = Colors.amber; // Food
                      } else {
                        color = Colors.white60; // Background
                      }

                      return Container(
                        margin: const EdgeInsets.all(1),
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
          ),

          // Game Over overlay
          if (!isPlaying && snake.length > 4)
            Expanded(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Game Over!',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: restartGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          'Play Again',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
