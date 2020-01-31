import 'dart:math' as math;
import 'dart:ui';

import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

_angleToRadians(double angle) => angle / 180 * math.pi;

/// Moves forward.
@immutable
class Forward implements TurtleCommand<void> {
  /// The distance in points.
  final double Function(Map) distance;

  /// Creates a new instance.
  Forward(this.distance);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final radians = _angleToRadians(turtle.degrees);
    final distance = this.distance(argv);
    final dx = math.cos(radians) * distance;
    final dy = math.sin(radians) * distance;
    final currentPosition = turtle.position;
    turtle.position = currentPosition + Offset(dx, dy);

    if (turtle.isPenDown) {
      return [DrawLineInstruction(currentPosition, turtle.position)];
    }
    return [];
  }
}
