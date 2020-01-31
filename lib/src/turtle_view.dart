import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class _TurtlePainter extends CustomPainter {
  final List<Instruction> commands;

  _TurtlePainter(this.commands);

  @override
  void paint(Canvas canvas, Size size) {
    var turtle = TurtleState();
    var context = PaintContext()
      ..canvas = canvas
      ..paint = (Paint()
        ..color = turtle.color
        ..strokeWidth = turtle.strokeWidth)
      ..center = Offset(size.width / 2, size.height / 2);
    commands.forEach((command) => command.exec(context));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// TurtleView takes commands and draw graphics in a canvas accordingly.
class TurtleView extends StatefulWidget {
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
  _TurtleViewState createState() => _TurtleViewState();
}

class _TurtleViewState extends State<TurtleView> {
  List<Instruction> instructions = [];

  @override
  void initState() {
    super.initState();
    instructions = TurtleCompiler.compile(widget.commands);
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _TurtlePainter(instructions),
        size: widget.size,
        isComplex: widget.isComplex,
        child: widget.child,
      );
}
