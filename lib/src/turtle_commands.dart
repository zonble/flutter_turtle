import 'painter.dart';
import 'turtle_state.dart';

/// An abstract interface for all commands.
abstract class TurtleCommand {
  List<Instruction> createInstruction(TurtleState turtle, Map argv);
}

/// An abstract interface for all commands.
abstract class Instruction<T> {
  /// Runs the instruction.
  T exec(PaintContext context);
}

/// Compiles a list of [TurtleCommand] to a list of [Instruction].
class TurtleCompiler {
  static List<Instruction> compile(List<TurtleCommand> commands) {
    var turtle = TurtleState();
    var argv = {};
    var list = List<Instruction>.of(commands
        .map((command) => command.createInstruction(turtle, argv))
        .expand((x) => x));
    return list;
  }
}
