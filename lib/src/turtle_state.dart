import 'dart:collection';

import 'package:flutter/material.dart';
import '../flutter_turtle.dart';

/// Represents macros.
class Macro {
  /// Commands in a macro.
  final List<TurtleCommand>? commands;

  /// Creates a new instance.
  Macro({required this.commands});
}

/// Represents the state of a turtle.
class TurtleState {
  /// If the pen is down.
  ///
  /// Or, if we should paint a line instead of merely moves the [position] of
  /// the turtle while calling commands like [Forward], [Back], [GoTo] and so
  /// on.
  bool isPenDown = false;

  /// The position of the turtle.
  ///
  /// The turtle is in the center of a canvas by default.
  Offset position = const Offset(0.0, 0.0);

  /// The angle of the turtle.
  ///
  /// It effect how the turtle moves while calling a [Forward] command.
  double degrees = -90.0;

  /// The macros.
  Map<String, Macro> macros = {};

  /// The color of the turtle.
  Color color = Colors.black;

  /// The current stroke width.
  double strokeWidth = 2;

  /// Height of labels.
  double labelHeight = 12;

  ///
  /// A queue that keeps track of the turtle's movements in a record
  /// (Offset, double).
  ///
  Queue turtleStack = Queue<(Offset position, double orientation)>();
}
