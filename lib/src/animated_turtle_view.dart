import 'package:flutter/material.dart';

import 'painter.dart';
import 'turtle_commands.dart';

/// A widget takes [commands] and draw Turtle Graphics with animations.
///
/// The widget animated when you build it. You can use the [animationDuration]
/// property to set the duration of the animations.
class AnimatedTurtleView extends StatefulWidget {
  /// The commands.
  final List<TurtleCommand> commands;

  /// The child widget.
  final Widget? child;

  /// Size of the canvas.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  final bool isComplex;

  /// The duration of the animation. 3 seconds by default.
  final Duration animationDuration;

  /// Creates a new instance.
  const AnimatedTurtleView({
    super.key,
    required this.commands,
    this.child,
    this.isComplex = false,
    this.size = Size.zero,
    this.animationDuration = const Duration(seconds: 3),
  });

  @override
  _AnimatedTurtleViewState createState() => _AnimatedTurtleViewState();
}

class _AnimatedTurtleViewState extends State<AnimatedTurtleView>
    with SingleTickerProviderStateMixin {
  List<Instruction> _instructions = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _instructions = TurtleCompiler.compile(widget.commands);
    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedTurtleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.commands != oldWidget.commands) {
      setState(() => _instructions = TurtleCompiler.compile(widget.commands));
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller.value = 0;
    _controller.forward();
    return AnimatedBuilder(
        child: widget.child,
        animation: _controller,
        builder: (context, child) {
          var value = _controller.value;
          var instructions =
              _instructions.sublist(0, (_instructions.length * value).toInt());
          return CustomPaint(
            painter: TurtlePainter(instructions),
            size: widget.size,
            isComplex: widget.isComplex,
            child: child,
          );
        });
  }
}
