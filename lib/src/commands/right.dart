import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Asks the turtle to right with the given [degrees].
///
/// See also [Left].
@immutable
class Right implements TurtleCommand {
  /// The angle.
  ///
  /// Please note that it is not radius.
  final double Function(Map) degrees;

  /// Creates a new instance.
  const Right(this.degrees);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.degrees += degrees(Map.of(argv));
    return [];
  }
}
