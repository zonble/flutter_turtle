import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';
import 'forward.dart';

/// Asks the turtle to move backward.
///
/// If the pen is down, draws a line.
@immutable
class Back implements TurtleCommand {
  /// The distance in points.
  final double Function(Map) distance;

  /// Creates a new instance.
  Back(this.distance);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    return Forward((_) => distance(argv) * -1).createInstruction(turtle, argv);
  }
}
