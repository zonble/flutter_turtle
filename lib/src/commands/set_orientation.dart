import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Sets a new orientation for drawing lines and texts.
@immutable
class SetOrientation implements TurtleCommand {
  /// The new color.
  final double degrees;

  /// Creates a new instance.
  const SetOrientation(this.degrees);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.degrees = degrees;
    return [];
  }
}
