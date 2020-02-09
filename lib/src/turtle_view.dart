import 'package:flutter/material.dart';

import 'painter.dart';
import 'turtle_commands.dart';

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
  List<Instruction> _instructions = [];

  @override
  void initState() {
    super.initState();
    _instructions = TurtleCompiler.compile(widget.commands);
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: TurtlePainter(_instructions),
        size: widget.size,
        isComplex: widget.isComplex,
        child: widget.child,
      );
}
