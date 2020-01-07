import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class TreePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tree')),
      body: TurtleView(
        child: Container(),
        commands: [
          SetMacro('tree', [
            IfElse((argv) => argv['size'] < 5.0, [
              Forward((argv) => argv['size']),
              Backward((argv) => argv['size']),
              Stop(),
            ], [
              Forward((argv) => (argv['size'] ~/ 3).toDouble()),
              Left((_) => 30.0),
              RunMacro('tree',
                  (argv) => {'size': ((argv['size'] * 2 ~/ 3)).toDouble()}),
              Right((_) => 30.0),
              Forward((argv) => (argv['size'] ~/ 6).toDouble()),
              Right((_) => 25.0),
              RunMacro(
                  'tree', (argv) => {'size': (argv['size'] / 2).toDouble()}),
              Left((_) => 25.0),
              Forward((argv) => (argv['size'] ~/ 3).toDouble()),
              Right((_) => 25.0),
              RunMacro(
                  'tree', (argv) => {'size': (argv['size'] / 2).toDouble()}),
              Left((_) => 25.0),
              Forward((argv) => (argv['size'] ~/ 6).toDouble()),
              Backward((argv) => argv['size'])
            ])
          ]),
          Left((_) => 180.0),
          Forward((_) => 140.0),
          Left((_) => 180.0),
          PenDown(),
          SetColor((_) => Colors.green),
          RunMacro('tree', (_) => {'size': 280.0}),
          PenUp(),
        ],
      ),
    );
  }
}
