import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

@immutable
class SetLabelHeight implements TurtleCommand {
  /// The new height.
  final double Function(Map) height;

  /// Creates a new instance.
  SetLabelHeight(this.height);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.labelHeight = height(argv);
    return [];
  }
}
