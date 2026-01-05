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
  GameInputJump(this.timestamp);
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
  GameInputRestart(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GameInputCubit extends Cubit<GameInputState> {
  GameInputCubit() : super(GameInputInitial());

  void jump() {
    emit(GameInputJump(DateTime.now().microsecondsSinceEpoch));
  }

  void move(Direction direction) {
    emit(GameInputMove(direction, DateTime.now().microsecondsSinceEpoch));
  }

  void restart() {
    emit(GameInputRestart(DateTime.now().microsecondsSinceEpoch));
  }
}
