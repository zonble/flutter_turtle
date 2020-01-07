import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';
import 'package:flutter_turtle/src/turtle_state.dart';

class _TurtlePainter extends CustomPainter {
  final List<TurtleCommand> commands;

  _TurtlePainter(this.commands);

  @override
  void paint(Canvas canvas, Size size) {
    var context = TurtleContext()
      ..turtle = TurtleState()
      ..canvas = canvas
      ..paint = (Paint()
        ..color = Colors.black
        ..strokeWidth = 2)
      ..center = Offset(size.width / 2, size.height / 2);
    commands.forEach((command) => command.exec(context, {}));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// TurtleView takes commands and draw graphics in a canvas accordingly.
class TurtleView extends StatelessWidget {
  /// The commands.
  final List<TurtleCommand> commands;

  /// The child widget.
  final Widget child;

  /// Size of the canvas.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  final bool isComplex;

  /// Creates a new instance.
  TurtleView({
    Key key,
    this.child,
    this.commands,
    this.isComplex = false,
    this.size = Size.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _TurtlePainter(commands),
        size: size,
        isComplex: isComplex,
        child: child,
      );
}
