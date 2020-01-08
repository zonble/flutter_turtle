import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

/// An example from https://www.calormen.com/jslogo/
class StarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star')),
      body: TurtleView(
        child: Container(),
        commands: [
          PenDown(),
          SetColor((_) => Colors.red),
          SetStrokeWidth((_) => 2),
          Repeat((_) => 5, [
            Forward((_) => 200),
            Right((_) => 144),
          ]),
          PenUp(),
        ],
      ),
    );
  }
}
