import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_exceptions.dart';

/// Stops the current running macro.
@immutable
class Stop implements TurtleCommand {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) =>
      throw StopException();
}
