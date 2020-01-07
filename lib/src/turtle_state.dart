import 'dart:ui';

import 'package:flutter_turtle/flutter_turtle.dart';

/// Represents macros.
class Macro {
  /// Commands in a macro.
  final List<TurtleCommand> commands;

  /// Creates a new instance.
  Macro({this.commands});
}

/// Represents the state of a turtle.
class TurtleState {
  /// If the pen is down.
  ///
  /// Or, if we should paint a line instead of merely moves the [position] of
  /// the turtle while calling commands like [Forward], [Backward], [GoTo]
  /// and so on.
  bool isPenDown = false;

  /// The position of the turtle.
  ///
  /// The turtle is in the center of a canvas by default.
  Offset position = Offset(0.0, 0.0);

  /// The angle of the turtle.
  ///
  /// It effect how the turtle moves while calling a [Forward] command.
  double degrees = -90.0;

  /// The macros.
  Map<String, Macro> macros = {};
}
