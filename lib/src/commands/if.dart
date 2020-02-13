import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Represents if..else flow control.
@immutable
class If implements TurtleCommand {
  /// The condition.
  final bool Function(Map) condition;

  /// The commands to run when the [condition] is true.
  final List<TurtleCommand> commands;

  /// Creates a new instance.
  If(this.condition, this.commands);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final copy = Map.of(argv);
    return condition(copy)
        ? List<Instruction>.of(commands
            .map((command) => command.createInstruction(turtle, copy))
            .expand((x) => x))
        : [];
  }
}
