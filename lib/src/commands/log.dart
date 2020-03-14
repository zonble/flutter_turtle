import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Stops the current running macro.
@immutable
class Log implements TurtleCommand {
  final String text;

  Log(this.text);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    print(this.text);
    return [];
  }
}
