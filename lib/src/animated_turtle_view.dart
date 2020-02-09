import 'package:flutter/material.dart';

import 'painter.dart';
import 'turtle_commands.dart';

/// The animated turtle view.
class AnimatedTurtleView extends StatefulWidget {
  /// The commands.
  final List<TurtleCommand> commands;

  /// The child widget.
  final Widget child;

  /// Size of the canvas.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  final bool isComplex;

  /// The duration of the animation.
  final Duration animationDuration;

  /// Creates a new instance.
  AnimatedTurtleView({
    Key key,
    this.child,
    this.commands,
    this.isComplex = false,
    this.size = Size.zero,
    this.animationDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _AnimatedTurtleViewState createState() => _AnimatedTurtleViewState();
}

class _AnimatedTurtleViewState extends State<AnimatedTurtleView>
    with SingleTickerProviderStateMixin {
  List<Instruction> _instructions = [];
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _instructions = TurtleCompiler.compile(widget.commands);
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
