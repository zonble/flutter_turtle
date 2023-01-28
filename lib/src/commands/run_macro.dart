import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_exceptions.dart';
import '_instructions.dart';

/// Runs a macro by a given [name].
@immutable
class RunMacro implements TurtleCommand {
  /// Name of the macro.
  final String name;

  /// The arguments.
  final Function(Map) macroArgv;

  /// If we want to preserve the previous state. True by default.
  final bool preserveState;

  /// Creates a new instance.
  RunMacro(
    this.name,
    this.macroArgv, {
    this.preserveState = true,
  });

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    var macro = turtle.macros[name];
    if (macro == null) {
      throw Exception('Macro does not exist');
    }

    final width = turtle.strokeWidth;
    final color = turtle.color;
    final degrees = turtle.degrees;
    final position = turtle.position;

    var instructions = <Instruction>[];
    var copy = Map.of(argv);
    copy.addAll(this.macroArgv(argv));

    try {
      var list = List<Instruction>.of(macro.commands
          .map((command) => command.createInstruction(turtle, copy))
          .expand((x) => x));
      instructions.addAll(list);
    } on StopException catch (_) {}

    if (preserveState) {
      instructions.addAll(<Instruction>[
        SetStrokeWidthInstruction(width),
        SetColorInstruction(color),
      ]);

      turtle.degrees = degrees;
      turtle.position = position;
    }
    return instructions;
  }
}
