import 'dart:ui';

import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

/// Sets a new color for drawing lines and texts.
@immutable
class SetColor implements TurtleCommand {
  /// The new color.
  final Color Function(Map) color;

  /// Creates a new instance.
  SetColor(this.color);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final copy = Map.of(argv);
    final newColor = color(copy);
    turtle.color = newColor;
    return [SetColorInstruction(newColor)];
  }
}
