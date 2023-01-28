import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Sets a macro.
///
/// Macros are like functions in the DSL of flutter_turtle. You can register
/// macros using [SetMacro] commands and run them using [RunMacro].
@immutable
class SetMacro implements TurtleCommand {
  /// Name of the macro.
  ///
  /// After setting the macro, you can use [RunMacro] to call the macro with the
  /// name.
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
