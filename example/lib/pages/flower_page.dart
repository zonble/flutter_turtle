import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class FlowerPage extends StatefulWidget {
  @override
  _FlowerPageState createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage> {
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

    var commands = [
      PenDown(),
      Repeat((_) => 8, [
        SetColor((_) => randomColor()),
        Repeat((_) => 2, [
          Repeat((_) => 100, [Forward((_) => 2.0), Right((_) => 1.0)]),
          Right((_) => 80.0)
        ]),
        Right((_) => 45.0),
      ]),
      PenUp(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flower'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => setState(() {}),
            child: Text('Run'),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'http://www.logointerpreter.com/view-program.php?user=Jannacutie&program=color%20flower'),
          ),
          AnimatedTurtleView(
            child: Container(
              width: double.infinity,
              height: 400,
            ),
            commands: commands,
          ),
        ],
      ),
    );
  }
}
