import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'turtle_state.dart';

_angleToRadians(double angle) => angle / 180 * math.pi;

/// Moves backward.
@immutable
class Backward implements TurtleCommand<void> {
  /// The distance in points.
  final double Function(Map) distance;

  /// Creates a new instance.
  Backward(this.distance);

  @override
  void exec(TurtleContext context, Map argv) =>
      Forward((_) => distance(argv) * -1).exec(context, argv);
}

/// Executes arbitrary code.
@immutable
class Exec implements TurtleCommand<void> {
  /// The function to run.
  final Function(TurtleContext context, Map argv) function;

  /// Creates a new instance.
  Exec(this.function);

  @override
  void exec(TurtleContext context, Map argv) => function(context, argv);
}

/// Moves forward.
@immutable
class Forward implements TurtleCommand<void> {
  /// The distance in points.
  final double Function(Map) distance;

  /// Creates a new instance.
  Forward(this.distance);

  @override
  void exec(TurtleContext context, Map argv) {
    final radians = _angleToRadians(context.turtle.degrees);
    final distance = this.distance(argv);
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
  void exec(TurtleContext context, Map argv) {
    final currentPosition = context.turtle.position;
    context.turtle.position = position(argv);

    if (context.turtle.isPenDown) {
      final drawingBegin = context.center + currentPosition;
      final drawingEnd = context.center + context.turtle.position;
      context.canvas.drawLine(drawingBegin, drawingEnd, context.paint);
    }
  }
}

@immutable
class IfElse implements TurtleCommand<void> {
  final bool Function(Map) condition;
  final List<TurtleCommand> truePath;
  final List<TurtleCommand> falsePath;

  IfElse(this.condition, this.truePath, this.falsePath);

  @override
  void exec(TurtleContext context, Map argv) {
    var commands = (condition(argv) ? truePath : falsePath);
    commands.forEach((command) => command.exec(context, argv));
  }
}

/// Turns left.
@immutable
class Left implements TurtleCommand<void> {
  /// The angle.
  ///
  /// Please note that it is not radius.
  final double Function(Map) degrees;

  /// Creates a new instance.
  Left(this.degrees);

  @override
  void exec(TurtleContext context, Map argv) =>
      context.turtle.degrees -= degrees(argv);
}

/// Puts the pen down.
@immutable
class PenDown implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context, Map argv) => context.turtle.isPenDown = true;
}

/// Raises the pen up.
@immutable
class PenUp implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context, Map argv) =>
      context.turtle.isPenDown = false;
}

/// Repeats commands
@immutable
class Repeat implements TurtleCommand<void> {
  /// How many times to repeat.
  final int Function(Map) times;

  /// The commands to run.
  final List<TurtleCommand> commands;

  /// Creates a new instance.
  Repeat(this.times, this.commands);

  @override
  void exec(TurtleContext context, Map argv) {
    for (var i = 0; i < times(argv); i++) {
      commands.forEach((command) => command.exec(context, argv));
    }
  }
}

/// Makes the turtle to face to top.
@immutable
class ResetHeading implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context, Map argv) => context.turtle.degrees = -90;
}

/// Moves the turtle to center.
@immutable
class ResetPosition implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context, Map argv) =>
      context.turtle.position = Offset(0.0, 0.0);
}

/// Turns right.
@immutable
class Right implements TurtleCommand<void> {
  /// The angle.
  ///
  /// Please note that it is not radius.
  final double Function(Map) degrees;

  /// Creates a new instance.
  Right(this.degrees);

  @override
  void exec(TurtleContext context, Map argv) =>
      context.turtle.degrees += degrees(argv);
}

/// Runs a macro by a given [name].
class RunMacro implements TurtleCommand<void> {
  /// Name of the macro.
  final String name;

  /// The arguments.
  final Function(Map) macroArgv;

  /// Creates a new instance.
  RunMacro(this.name, this.macroArgv);

  @override
  void exec(TurtleContext context, Map argv) {
    var macro = context.turtle.macros[name];
    if (macro == null) {
      throw Exception('Macro does not exist');
    }
    var width = context.paint.strokeWidth;
    var color = context.paint.color;
    var degrees = context.turtle.degrees;
    var position = context.turtle.position;

    var arg = this.macroArgv(argv);
    try {
      macro.commands.forEach((command) {
        return command.exec(context, arg);
      });
    } catch (error) {
//      print('macro error $error');
    }

    context.paint.strokeWidth = width;
    context.paint.color = color;
    context.turtle.degrees = degrees;
    context.turtle.position = position;
  }
}

/// Sets a new color.
@immutable
class SetColor implements TurtleCommand<void> {
  /// The new color.
  final Color Function(Map) color;

  /// Creates a new color.
  SetColor(this.color);

  @override
  void exec(TurtleContext context, Map argv) =>
      context.paint.color = color(argv);
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
  void exec(TurtleContext context, Map argv) {
    context.turtle.macros[name] = Macro(commands: commands);
  }
}

/// Sets a new stroke width.
@immutable
class SetStrokeWidth implements TurtleCommand<void> {
  /// The new width.
  final double Function(Map) width;

  /// Creates a new instance.
  SetStrokeWidth(this.width);

  @override
  void exec(TurtleContext context, Map argv) =>
      context.paint.strokeWidth = width(argv);
}

/// Stops drawing.
@immutable
class Stop implements TurtleCommand<void> {
  @override
  void exec(TurtleContext context, Map argv) =>
      throw Exception('Stop executing.');
}

/// An abstract interface for all commands.
abstract class TurtleCommand<T> {
  /// Runs the command.
  T exec(TurtleContext context, Map argv);
}

class TurtleContext {
  TurtleState turtle;
  Canvas canvas;
  Paint paint;
  Offset center;
}
