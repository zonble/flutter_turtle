import 'package:flutter/widgets.dart';

import 'turtle_commands.dart';
import 'turtle_state.dart';

/// A [CustomPainter] implementation for rendering turtle graphics.
///
/// This painter is responsible for interpreting turtle commands and drawing the
/// resulting graphics on a canvas. It works in conjunction with the turtle
/// graphics system to render paths, shapes, and other visual elements created
/// through turtle movement commands.
///
/// Used by [TurtleView] to display the turtle's drawing output.
class TurtlePainter extends CustomPainter {
  /// A list of drawing instructions that the painter will execute.
  ///
  /// This list contains the sequence of [Instruction]s that define the drawing
  /// operations to be performed on the canvas when the painter is rendered.
  final List<Instruction> instructions;

  /// Creates a [TurtlePainter] with the specified turtle drawing instructions.
  ///
  /// The [instructions] parameter is a list of [TurtleCommand] objects that
  /// define the sequence of drawing operations to be performed by the turtle.
  TurtlePainter(this.instructions);

  @override
  void paint(Canvas canvas, Size size) {
    var turtle = TurtleState();
    var context = PaintContext(
      canvas: canvas,
      paint: (Paint()
        ..color = turtle.color
        ..strokeWidth = turtle.strokeWidth),
      center: Offset(size.width / 2, size.height / 2),
    );
    for (var command in instructions) {
      command.exec(context);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// Context for painting operations in the Turtle Graphics system.
///
/// [PaintContext] encapsulates the state and configuration needed for the
/// turtle to perform drawing operations, including position, direction, pen
/// status, and styling attributes.
///
/// This is used internally by the turtle commands to maintain the drawing state
/// during execution of turtle programs.
@immutable
class PaintContext {
  final Canvas canvas;
  final Paint paint;
  final Offset center;

  const PaintContext({
    required this.canvas,
    required this.paint,
    required this.center,
  });
}
