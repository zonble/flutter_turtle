import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'turtle_state.dart';

/// An abstract interface for all commands.
abstract class TurtleCommand {
  /// Runs the command.
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center);
}

/// Puts the pen down.
@immutable
class PenDown implements TurtleCommand {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.isPenDown = true;
}

/// Raises the pen up.
@immutable
class PenUp implements TurtleCommand {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.isPenDown = false;
}

/// Turns left.
@immutable
class Left implements TurtleCommand {
  /// the angle.
  final double Function() angle;

  /// Creates a new instance.
  Left(this.angle);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.angle += angle();
}

/// Turns right.
@immutable
class Right implements TurtleCommand {
  /// the right.
  final double Function() angle;

  /// Creates a new instance.
  Right(this.angle);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.angle -= angle();
}

_angleToRadians(double angle) => angle / 180 * math.pi;

/// Moves forward.
@immutable
class Forward implements TurtleCommand {
  /// The distance.
  final double Function() distance;

  /// Creates a new instance.
  Forward(this.distance);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) {
    final radians = _angleToRadians(turtle.angle);
    final distance = this.distance();
    final x = math.cos(radians) * distance;
    final y = math.sin(radians) * distance;
    final currentPosition = turtle.position;
    turtle.position = currentPosition + Offset(x, y);

    if (turtle.isPenDown) {
      final drawingBegin = center + currentPosition;
      final drawingEnd = center + turtle.position;
      canvas.drawLine(drawingBegin, drawingEnd, paint);
    }
  }
}

/// Sets a new color.
@immutable
class SetColor implements TurtleCommand {
  /// The new color.
  final Color Function() color;

  /// Creates a new color.
  SetColor(this.color);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      paint.color = color();
}

/// Moves the turtle to center.
@immutable
class ResetPosition implements TurtleCommand {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.position = Offset(0.0, 0.0);
}

/// Makes the turtle to face to top.
@immutable
class ResetHeading implements TurtleCommand {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.angle = 90;
}

/// Repeats commands
@immutable
class Repeat implements TurtleCommand {
  /// How many times to repeat.
  final int Function() times;

  /// The commands to run.
  final List<TurtleCommand> commands;

  /// Creates a new instance.
  Repeat(this.times, this.commands);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) {
    for (var i = 0; i < times(); i++) {
      commands.forEach((command) {
        command.exec(turtle, canvas, paint, center);
      });
    }
  }
}
