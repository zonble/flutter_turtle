import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_exceptions.dart';

/// Stops drawing.
@immutable
class Stop implements TurtleCommand<void> {
  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) =>
      throw StopException();
}
