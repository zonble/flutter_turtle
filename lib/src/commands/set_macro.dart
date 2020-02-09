import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';


/// Sets a macro.
@immutable
class SetMacro implements TurtleCommand {
  /// Name of the macro.
  final String name;

  /// Commands in the macro.
  final List<TurtleCommand> commands;

  /// Creates a new instance.
  SetMacro(this.name, this.commands);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.macros[name] = Macro(commands: commands);
    return [];
  }
}
