import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Raises the pen up.
///
/// After [PenUp] is called, commands like [Forward] and [Back] would not draw
/// lines.
@immutable
class PenUp implements TurtleCommand {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.isPenDown = false;
    return [];
  }
}
