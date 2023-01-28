import 'package:flutter/material.dart';

import 'painter.dart';
import 'turtle_commands.dart';

/// A widget takes [commands] and draw Turtle Graphics in a canvas accordingly.
///
/// The widget does not have any animation effects.
class TurtleView extends StatefulWidget {
  /// The commands.
  final List<TurtleCommand> commands;

  /// The child widget.
  final Widget? child;

  /// Size of the canvas.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  final bool isComplex;

  /// Creates a new instance.
  const TurtleView({
    super.key,
    required this.commands,
    this.child,
    this.isComplex = false,
    this.size = Size.zero,
  });

  @override
  State<TurtleView> createState() => _TurtleViewState();
}

class _TurtleViewState extends State<TurtleView> {
  @override
  void didUpdateWidget(covariant TurtleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Instruction> instructions = TurtleCompiler.compile(widget.commands);
    return CustomPaint(
      painter: TurtlePainter(instructions),
      size: widget.size,
      isComplex: widget.isComplex,
      child: widget.child,
    );
  }
}
