import 'package:flutter/material.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Puts the turtle back into the last recorded position and orientation
@immutable
class PopState implements TurtleCommand {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    if (turtle.turtleStack.isNotEmpty) {
      (Offset position, double orientation) lastState =
          turtle.turtleStack.removeLast();
      turtle.position = lastState.$1;
      turtle.degrees = lastState.$2;
    }
    return [];
  }
}
