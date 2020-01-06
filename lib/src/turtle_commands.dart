import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'turtle_state.dart';

/// An abstract interface for all commands.
abstract class TurtleCommand<T> {
  /// Runs the command.
  T exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center);
}

/// Executes arbitrary code.
@immutable
class Exec implements TurtleCommand<void> {
  /// The function to run.
  final Function(TurtleState turtle, Canvas canvas, Paint paint, Offset center)
      function;

  /// Creates a new instance.
  Exec(this.function);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      function(turtle, canvas, paint, center);
}

/// Puts the pen down.
@immutable
class PenDown implements TurtleCommand<void> {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.isPenDown = true;
}

/// Raises the pen up.
@immutable
class PenUp implements TurtleCommand<void> {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.isPenDown = false;
}

/// Turns left.
@immutable
class Left implements TurtleCommand<void> {
  /// The angle.
  ///
  /// Please note that it is not radius.
  final double Function() degrees;

  /// Creates a new instance.
  Left(this.degrees);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.degrees += degrees();
}

/// Turns right.
@immutable
class Right implements TurtleCommand<void> {
  /// The angle.
  ///
  /// Please note that it is not radius.
  final double Function() degrees;

  /// Creates a new instance.
  Right(this.degrees);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.degrees -= degrees();
}

_angleToRadians(double angle) => angle / 180 * math.pi;

/// Moves forward.
@immutable
class Forward implements TurtleCommand<void> {
  /// The distance in points.
  final double Function() distance;

  /// Creates a new instance.
  Forward(this.distance);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) {
    final radians = _angleToRadians(turtle.degrees);
    final distance = this.distance();
    final dx = math.cos(radians) * distance;
    final dy = math.sin(radians) * distance;
    final currentPosition = turtle.position;
    turtle.position = currentPosition + Offset(dx, dy);

    if (turtle.isPenDown) {
      final drawingBegin = center + currentPosition;
      final drawingEnd = center + turtle.position;
      canvas.drawLine(drawingBegin, drawingEnd, paint);
    }
  }
}

/// Moves backward.
@immutable
class Backward implements TurtleCommand<void> {
  /// The distance in points.
  final double Function() distance;

  /// Creates a new instance.
  Backward(this.distance);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      Forward(() => distance() * -1).exec(turtle, canvas, paint, center);
}

/// Sets a new color.
@immutable
class SetColor implements TurtleCommand<void> {
  /// The new color.
  final Color Function() color;

  /// Creates a new color.
  SetColor(this.color);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      paint.color = color();
}

/// Sets a new stroke width.
@immutable
class SetStrokeWidth implements TurtleCommand<void> {
  /// The new width.
  final double Function() width;

  /// Creates a new instance.
  SetStrokeWidth(this.width);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      paint.strokeWidth = width();
}

/// Moves the turtle to an absolute position.
///
/// If the pen is down, draws a line.
@immutable
class GoTo implements TurtleCommand<void> {
  /// Position X.
  final double x;

  /// Position Y.
  final double y;

  /// Creates a new instance.
  GoTo(this.x, this.y);

  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) {
    final currentPosition = turtle.position;
    turtle.position = Offset(x, y);

    if (turtle.isPenDown) {
      final drawingBegin = center + currentPosition;
      final drawingEnd = center + turtle.position;
      canvas.drawLine(drawingBegin, drawingEnd, paint);
    }
  }
}

/// Moves the turtle to center.
@immutable
class ResetPosition implements TurtleCommand<void> {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.position = Offset(0.0, 0.0);
}

/// Makes the turtle to face to top.
@immutable
class ResetHeading implements TurtleCommand<void> {
  @override
  void exec(TurtleState turtle, Canvas canvas, Paint paint, Offset center) =>
      turtle.degrees = 90;
}

/// Repeats commands
@immutable
class Repeat implements TurtleCommand<void> {
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
