import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

@immutable
class Label implements TurtleCommand<void> {
  /// The text.
  final String Function(Map) text;

  /// Creates a new instance.
  Label(this.text);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    var labelText = text(argv);
    return [
      DrawTextInstruction(
        text: labelText,
        color: turtle.color,
        degrees: turtle.degrees,
        position: turtle.position,
        labelHeight: turtle.labelHeight,
      )
    ];
  }
}
