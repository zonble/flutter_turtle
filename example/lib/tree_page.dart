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
            IfElse((argv) => argv['size'].toDouble() < 5.0, [
              Forward((argv) => argv['size'].toDouble()),
              Backward((argv) => argv['size'].toDouble()),
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
              Backward((argv) => argv['size'].toDouble())
            ])
          ]),
          PenDown(),
          RunMacro('tree', (_) => {'size': 200.0}),
          PenUp(),
        ],
      ),
    );
  }
}
