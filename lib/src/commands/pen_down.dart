import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Puts the pen down.
@immutable
class PenDown implements TurtleCommand {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.isPenDown = true;
    return [];
  }
}
