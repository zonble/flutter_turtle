import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Sets the height of the labels.
/// 
/// You can use [Label] to draw texts.
@immutable
class SetLabelHeight implements TurtleCommand {
  /// The new height.
  final double Function(Map) height;

  /// Creates a new instance.
  SetLabelHeight(this.height);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    if (height == null) return [];
    turtle.labelHeight = height(Map.of(argv));
    return [];
  }
}
