import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:annike_game/screen/snake_game.dart'; // For Direction enum

abstract class GameInputState extends Equatable {
  const GameInputState();

  @override
  List<Object> get props => [];
}

class GameInputInitial extends GameInputState {}

class GameInputJump extends GameInputState {
  // Unique ID to ensure state change even if repeated
  final int timestamp;
  const GameInputJump(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GameInputMove extends GameInputState {
  final Direction direction;
  final int timestamp;

  const GameInputMove(this.direction, this.timestamp);

  @override
  List<Object> get props => [direction, timestamp];
}

class GameInputRestart extends GameInputState {
  final int timestamp;
  const GameInputRestart(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GameInputGameOver extends GameInputState {
  final int timestamp;
  final int flappyBirdScore;
  final int snakeScore;

  const GameInputGameOver({
    required this.timestamp,
    required this.flappyBirdScore,
    required this.snakeScore,
  });

  @override
  List<Object> get props => [timestamp, flappyBirdScore, snakeScore];
}

class GameInputCubit extends Cubit<GameInputState> {
  GameInputCubit() : super(GameInputInitial());

  int _flappyBirdScore = 0;
  int _snakeScore = 0;

  void jump() {
    emit(GameInputJump(DateTime.now().microsecondsSinceEpoch));
  }

  void move(Direction direction) {
    emit(GameInputMove(direction, DateTime.now().microsecondsSinceEpoch));
  }

  void restart() {
    _flappyBirdScore = 0;
    _snakeScore = 0;
    emit(GameInputRestart(DateTime.now().microsecondsSinceEpoch));
  }

  void gameOver({int flappyBirdScore = 0, int snakeScore = 0}) {
    _flappyBirdScore = flappyBirdScore;
    _snakeScore = snakeScore;
    emit(
      GameInputGameOver(
        timestamp: DateTime.now().microsecondsSinceEpoch,
        flappyBirdScore: flappyBirdScore,
        snakeScore: snakeScore,
      ),
    );
  }

  int get flappyBirdScore => _flappyBirdScore;
  int get snakeScore => _snakeScore;
}
