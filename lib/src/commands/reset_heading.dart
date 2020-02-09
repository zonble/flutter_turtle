import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Makes the turtle to face to top.
@immutable
class ResetHeading implements TurtleCommand {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.degrees = -90;
    return [];
  }
}
