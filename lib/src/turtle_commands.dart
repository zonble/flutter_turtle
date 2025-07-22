import 'commands/_exceptions.dart';
import 'painter.dart';
import 'turtle_state.dart';

/// An abstract interface for all commands.
abstract interface class TurtleCommand {
  /// Creates instructions.
  List<Instruction> createInstruction(TurtleState turtle, Map argv);
}

/// An abstract interface for all commands.
abstract interface class Instruction<T> {
  /// Runs the instruction.
  T exec(PaintContext context);
}

/// Compiles a list of [TurtleCommand] to a list of [Instruction].
class TurtleCompiler {
  /// Compiles commands to instructions.
  static List<Instruction> compile(List<TurtleCommand> commands) {
    final turtle = TurtleState();
    final argv = {};
    var instructions = <Instruction>[];
    try {
      for (var command in commands) {
        instructions.addAll(command.createInstruction(turtle, argv));
      }
    } on StopException catch (_) {}
    return instructions;
  }
}
