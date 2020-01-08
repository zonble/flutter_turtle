import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';
import 'dart:math';

class FlowerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color randomColor() {
      var colors = [
        Colors.red,
        Colors.yellow,
        Colors.orange,
        Colors.blue,
        Colors.pink,
        Colors.deepPurple,
        Colors.purple,
      ];
      return colors[Random().nextInt(colors.length)];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Flower')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
              'http://www.logointerpreter.com/view-program.php?user=Jannacutie&program=color%20flower'),
          TurtleView(
            child: Container(
              width: double.infinity,
              height: 400,
            ),
            commands: [
              PenDown(),
              Repeat((_) => 8, [
                SetColor((_) => randomColor()),
                Repeat((_) => 2, [
                  Repeat((_) => 100, [
                    Forward((_) => 2.0),
                    Right((_) => 1.0),
                  ]),
                  Right((_) => 80.0)
                ]),
                Right((_) => 45.0),
              ]),
              PenUp(),
            ],
          ),
        ],
      ),
    );
  }
}
