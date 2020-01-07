import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'turtle_state.dart';

class TurtleContext {
  TurtleState turtle;
  Canvas canvas;
  Paint paint;
  Offset center;
}

/// An abstract interface for all commands.
abstract class TurtleCommand<T> {
  /// Runs the command.
  T exec(TurtleContext context);
}

/// Stops drawing.
@immutable
class Stop implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context) => throw Exception('Stop executing.');
}

@immutable
class IfElse implements TurtleCommand<void> {
  final bool Function() condition;
  final List<TurtleCommand> truePath;
  final List<TurtleCommand> falsePath;

  IfElse({this.condition, this.truePath, this.falsePath});

  @override
  void exec(TurtleContext context) {
    (condition() ? truePath : falsePath)
        .forEach((command) => command.exec(context));
  }
}

/// Sets a macro.
@immutable
class SetMacro implements TurtleCommand<void> {
  /// Name of the macro.
  final String name;

  /// Commands in the macro.
  final List<TurtleCommand> commands;

  /// Creates a new instance.
  SetMacro(this.name, this.commands);

  @override
  void exec(TurtleContext context) =>
      context.turtle.macros[name] = Macro(commands: commands);
}

/// Executes arbitrary code.
@immutable
class Exec implements TurtleCommand<void> {
  /// The function to run.
  final Function(TurtleContext context) function;

  /// Creates a new instance.
  Exec(this.function);

  @override
  void exec(TurtleContext context) => function(context);
}

/// Puts the pen down.
@immutable
class PenDown implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context) => context.turtle.isPenDown = true;
}

/// Raises the pen up.
@immutable
class PenUp implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context) => context.turtle.isPenDown = false;
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
  void exec(TurtleContext context) => context.turtle.degrees += degrees();
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
  void exec(TurtleContext context) => context.turtle.degrees -= degrees();
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
  void exec(TurtleContext context) {
    final radians = _angleToRadians(context.turtle.degrees);
    final distance = this.distance();
    final dx = math.cos(radians) * distance;
    final dy = math.sin(radians) * distance;
    final currentPosition = context.turtle.position;
    context.turtle.position = currentPosition + Offset(dx, dy);

    if (context.turtle.isPenDown) {
      final drawingBegin = context.center + currentPosition;
      final drawingEnd = context.center + context.turtle.position;
      context.canvas.drawLine(drawingBegin, drawingEnd, context.paint);
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
  void exec(TurtleContext context) =>
      Forward(() => distance() * -1).exec(context);
}

/// Sets a new color.
@immutable
class SetColor implements TurtleCommand<void> {
  /// The new color.
  final Color Function() color;

  /// Creates a new color.
  SetColor(this.color);

  @override
  void exec(TurtleContext context) => context.paint.color = color();
}

/// Sets a new stroke width.
@immutable
class SetStrokeWidth implements TurtleCommand<void> {
  /// The new width.
  final double Function() width;

  /// Creates a new instance.
  SetStrokeWidth(this.width);

  @override
  void exec(TurtleContext context) => context.paint.strokeWidth = width();
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
  void exec(TurtleContext context) {
    final currentPosition = context.turtle.position;
    context.turtle.position = Offset(x, y);

    if (context.turtle.isPenDown) {
      final drawingBegin = context.center + currentPosition;
      final drawingEnd = context.center + context.turtle.position;
      context.canvas.drawLine(drawingBegin, drawingEnd, context.paint);
    }
  }
}

/// Moves the turtle to center.
@immutable
class ResetPosition implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context) =>
      context.turtle.position = Offset(0.0, 0.0);
}

/// Makes the turtle to face to top.
@immutable
class ResetHeading implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context) => context.turtle.degrees = 90;
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
  void exec(TurtleContext context) {
    for (var i = 0; i < times(); i++) {
      commands.forEach((command) => command.exec(context));
    }
  }
}
