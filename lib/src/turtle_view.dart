import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';
import 'package:flutter_turtle/src/turtle_state.dart';

class _TurtlePainter extends CustomPainter {
  final List<TurtleCommand> commands;

  _TurtlePainter(this.commands);

  @override
  void paint(Canvas canvas, Size size) {
    var turtle = TurtleState();
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    var center = Offset(size.width / 2, size.height / 2);
    for (final command in commands) {
      command.exec(turtle, canvas, paint, center);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TurtleView extends StatelessWidget {
  final List<TurtleCommand> commands;
  final Widget child;

  TurtleView({Key key, this.child, this.commands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TurtlePainter(commands),
      child: child,
    );
  }
}
