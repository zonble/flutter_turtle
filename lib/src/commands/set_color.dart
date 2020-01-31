import 'dart:ui';

import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

/// Sets a new color.
@immutable
class SetColor implements TurtleCommand<void> {
  /// The new color.
  final Color Function(Map) color;

  /// Creates a new color.
  SetColor(this.color);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final newColor = color(argv);
    turtle.color = newColor;
    return [SetColorInstruction(newColor)];
  }
}
