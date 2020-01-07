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
          SetColor(() => Color(0xffff9933)),
          SetStrokeWidth(() => 2),
          Repeat(() => 20, [
            Repeat(() => 180, [
              Forward(() => 25.0),
              Right(() => 20),
            ]),
            Right(() => 18),
          ]),
          PenUp(),
        ],
      ),
    );
  }
}
