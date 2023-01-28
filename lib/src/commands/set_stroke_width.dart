import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import '_instructions.dart';

/// Sets a new stroke width.
@immutable
class SetStrokeWidth implements TurtleCommand {
  /// The new width.
  final double Function(Map) width;

  /// Creates a new instance.
  const SetStrokeWidth(this.width);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final newWidth = width(Map.of(argv));
    turtle.strokeWidth = newWidth;
    return [SetStrokeWidthInstruction(newWidth)];
  }
}
