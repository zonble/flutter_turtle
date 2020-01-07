import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logo')),
      body: TurtleView(
        child: Container(),
        commands: [
          PenDown(),
          SetColor((_) => Color(0xffff9933)),
          SetStrokeWidth((_) => 2),
          Repeat((_) => 20, [
            Repeat((_) => 180, [
              Forward((_) => 25.0),
              Right((_) => 20),
            ]),
            Right((_) => 18),
          ]),
          PenUp(),
        ],
      ),
    );
  }
}
