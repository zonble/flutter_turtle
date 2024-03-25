import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Saves the position and orientation of the turtle
@immutable
class SaveState implements TurtleCommand {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.turtleStack.add((turtle.position, turtle.degrees));
    return [];
  }
}
