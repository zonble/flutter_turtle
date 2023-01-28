import 'package:flutter/widgets.dart';

import 'turtle_commands.dart';
import 'turtle_state.dart';

class TurtlePainter extends CustomPainter {
  final List<Instruction> instructions;

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

class PaintContext {
  Canvas canvas;
  Paint paint;
  Offset center;

  PaintContext({
    required this.canvas,
    required this.paint,
    required this.center,
  });
}
