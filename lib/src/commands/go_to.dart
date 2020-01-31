import 'dart:ui';

import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

/// Moves the turtle to an absolute position.
///
/// If the pen is down, draws a line.
@immutable
class GoTo implements TurtleCommand<void> {
  /// Position.
  final Offset Function(Map) position;

  /// Creates a new instance.
  GoTo(this.position);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final currentPosition = turtle.position;
    turtle.position = position(argv);

    if (turtle.isPenDown) {
      return [DrawLineInstruction(currentPosition, turtle.position)];
    }
    return [];
  }
}
