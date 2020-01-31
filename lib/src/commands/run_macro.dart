import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_exceptions.dart';
import '_instructions.dart';

/// Turns right.

/// Runs a macro by a given [name].
@immutable
class RunMacro implements TurtleCommand<void> {
  /// Name of the macro.
  final String name;

  /// The arguments.
  final Function(Map) macroArgv;

  /// Creates a new instance.
  RunMacro(this.name, this.macroArgv);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    var macro = turtle.macros[name];
    if (macro == null) {
      throw Exception('Macro does not exist');
    }

    var width = turtle.strokeWidth;
    var color = turtle.color;
    var degrees = turtle.degrees;
    var position = turtle.position;

    var instructions = <Instruction>[];
    var arg = this.macroArgv(argv);
    try {
      var list = List<Instruction>.of(macro.commands
          .map((command) => command.createInstruction(turtle, arg))
          .expand((x) => x));
      instructions.addAll(list);
    } on StopException catch (_) {}

    instructions.addAll(<Instruction>[
      SetStrokeWidthInstruction(width),
      SetColorInstruction(color),
    ]);

    turtle.degrees = degrees;
    turtle.position = position;
    return instructions;
  }
}
