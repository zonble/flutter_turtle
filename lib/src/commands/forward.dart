import 'dart:math' as math;
import 'dart:ui';

import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

double _angleToRadians(double angle) => angle / 180 * math.pi;

/// Asks the turtle to move forward.
///
/// If the pen is down, draws a line.
@immutable
class Forward implements TurtleCommand {
  /// The distance in points.
  final double Function(Map) distance;

  /// Creates a new instance.
  const Forward(this.distance);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final copy = Map.of(argv);
    final radians = _angleToRadians(turtle.degrees);
    final double distance = this.distance(copy);
    final dx = math.cos(radians) * distance;
    final dy = math.sin(radians) * distance;
    final currentPosition = turtle.position;
    turtle.position = currentPosition + Offset(dx, dy);

    return turtle.isPenDown
        ? [DrawLineInstruction(currentPosition, turtle.position)]
        : [];
  }
}
