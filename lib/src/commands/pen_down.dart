import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Puts the pen down.
///
/// After [PenUp] is called, commands like [Forward] and [Back] draw lines.
@immutable
class PenDown implements TurtleCommand {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.isPenDown = true;
    return [];
  }
}
