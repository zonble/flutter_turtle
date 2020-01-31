import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'turtle_state.dart';

/// An abstract interface for all commands.
abstract class TurtleCommand<T> {
  List<Instruction> createInstruction(TurtleState turtle, Map argv);
}

/// An abstract interface for all commands.
abstract class Instruction<T> {
  /// Runs the instruction.
  T exec(PaintContext context);
}

class PaintContext {
  Canvas canvas;
  Paint paint;
  Offset center;
}

class TurtleCompiler {
  static List<Instruction> compile(List<TurtleCommand> commands) {
    var turtle = TurtleState();
    var argv = {};
    var list = List<Instruction>.of(commands
        .map((command) => command.createInstruction(turtle, argv))
        .expand((x) => x));
    return list;
  }
}
