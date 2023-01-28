import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

/// Draws texts.
///
/// You can use [SetLabelHeight] to set the size of the text, and use
/// [SetColor] to set the color.
@immutable
class Label implements TurtleCommand {
  /// The text.
  final String Function(Map) text;

  /// Creates a new instance.
  Label(this.text);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
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
