import 'package:flutter/material.dart';

import 'painter.dart';
import 'turtle_commands.dart';

/// A widget that draws Turtle Graphics and you can specify its progress by a
/// given [controller].
class ControllableTurtleView extends StatefulWidget {
  /// The commands.
  final List<TurtleCommand> commands;

  /// The child widget.
  final Widget? child;

  /// Size of the canvas.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  final bool isComplex;

  /// The controller that controls the progress of the view.
  final AnimationController controller;

  /// Creates a new instance.
  const ControllableTurtleView({
    super.key,
    required this.commands,
    required this.controller,
    this.child,
    this.isComplex = false,
    this.size = Size.zero,
  });

  @override
  State<ControllableTurtleView> createState() => _ControllableTurtleViewState();
}

class _ControllableTurtleViewState extends State<ControllableTurtleView> {
  List<Instruction> _instructions = [];

  @override
  void initState() {
    super.initState();
    _instructions = TurtleCompiler.compile(widget.commands);
  }

  @override
  void didUpdateWidget(ControllableTurtleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.commands != oldWidget.commands) {
      setState(() => _instructions = TurtleCompiler.compile(widget.commands));
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        double value = widget.controller.value;
        if (value < 0) value = 0;
        if (value > 1) value = 1;
        var instructions =
            _instructions.sublist(0, (_instructions.length * value).toInt());
        return CustomPaint(
          painter: TurtlePainter(instructions),
          size: widget.size,
          isComplex: widget.isComplex,
          child: child,
        );
      },
      child: widget.child);
}
