import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

@immutable
class Label implements TurtleCommand {
  /// The text.
  final String Function(Map) text;

  /// Creates a new instance.
  Label(this.text);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    if (text == null) return [];

    return [
      DrawTextInstruction(
        text: text(Map.of(argv)),
        color: turtle.color,
        degrees: turtle.degrees,
        position: turtle.position,
        labelHeight: turtle.labelHeight,
      )
    ];
  }
}
