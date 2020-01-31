import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Raises the pen up.
@immutable
class PenUp implements TurtleCommand<void> {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.isPenDown = false;
    return [];
  }
}
