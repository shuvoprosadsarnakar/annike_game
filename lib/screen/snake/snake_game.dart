import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for keyboard events

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

  // Focus node for keyboard input
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    startGame();
    // Request focus after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

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
    // Request focus again after restart
    _focusNode.requestFocus();
  }

  // Handle keyboard input
  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      // Arrow keys
      if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
          direction != Direction.down) {
        setState(() {
          direction = Direction.up;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
          direction != Direction.up) {
        setState(() {
          direction = Direction.down;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
          direction != Direction.right) {
        setState(() {
          direction = Direction.left;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
          direction != Direction.left) {
        setState(() {
          direction = Direction.right;
        });
      }
      // WASD keys
      else if (event.logicalKey == LogicalKeyboardKey.keyW &&
          direction != Direction.down) {
        setState(() {
          direction = Direction.up;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.keyS &&
          direction != Direction.up) {
        setState(() {
          direction = Direction.down;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.keyA &&
          direction != Direction.right) {
        setState(() {
          direction = Direction.left;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.keyD &&
          direction != Direction.left) {
        setState(() {
          direction = Direction.right;
        });
      }
      // R to restart
      else if (event.logicalKey == LogicalKeyboardKey.keyR) {
        restartGame();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: Container(
        color: const Color(0xFF343434),
        child: Stack(
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
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(60),
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (direction != Direction.up && details.delta.dy > 0) {
                        setState(() {
                          direction = Direction.down;
                        });
                      } else if (direction != Direction.down &&
                          details.delta.dy < 0) {
                        setState(() {
                          direction = Direction.up;
                        });
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (direction != Direction.left && details.delta.dx > 0) {
                        setState(() {
                          direction = Direction.right;
                        });
                      } else if (direction != Direction.right &&
                          details.delta.dx < 0) {
                        setState(() {
                          direction = Direction.left;
                        });
                      }
                    },
                    onTap: () {
                      // Request focus when user taps the game board
                      _focusNode.requestFocus();
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
                            borderRadius: BorderRadius.circular(0),
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
              Center(
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
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
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
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
