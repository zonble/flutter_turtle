import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class FlowerPage extends StatefulWidget {
  const FlowerPage({super.key});

  @override
  State<FlowerPage> createState() => _FlowerPageState();
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

    final commands = [
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
        appBar: AppBar(title: const Text('Flower'), actions: <Widget>[
          TextButton(
            onPressed: () => setState(() {}),
            child: const Text('Run', style: TextStyle(color: Colors.white)),
          )
        ]),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    'http://www.logointerpreter.com/view-program.php?user=Jannacutie&program=color%20flower'),
              ),
              AnimatedTurtleView(
                commands: commands,
                child: const SizedBox(width: double.infinity, height: 400),
              )
            ]));
  }
}
