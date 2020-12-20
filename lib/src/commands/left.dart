import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

/// Asks the turtle to turn left with the given [degrees].
///
/// See also [Right].
@immutable
class Left implements TurtleCommand {
  /// The angle.
  ///
  /// Please note that it is not radius.
  final double Function(Map) degrees;

  /// Creates a new instance.
  Left(this.degrees);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    turtle.degrees -= degrees(Map.of(argv));
    return [];
  }
}
