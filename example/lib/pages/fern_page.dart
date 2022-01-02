import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

/// An example from https://www.calormen.com/jslogo/
class FernPage extends StatefulWidget {
  const FernPage({Key? key}) : super(key: key);

  @override
  _FernPageState createState() => _FernPageState();
}

class _FernPageState extends State<FernPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fern'), actions: <Widget>[
        TextButton(
          onPressed: () => setState(() {}),
          child: const Text('Run', style: TextStyle(color: Colors.white)),
        )
      ]),
      body: AnimatedTurtleView(
        child: Container(),
        commands: [
          SetMacro('fern', [
            IfElse((_) => _['size'] < 1.0, [
              Stop()
            ], [
              Forward((_) => _['size']),
              Right((_) => 70.0 * _['sign']),
              RunMacro('fern',
                  (_) => {'size': _['size'] * 0.5, 'sign': _['sign'] * -1}),
              Left((_) => 70.0 * _['sign']),
              Forward((_) => _['size']),
              Left((_) => 70.0 * _['sign']),
              RunMacro(
                  'fern', (_) => {'size': _['size'] * 0.5, 'sign': _['sign']}),
              Right((_) => 70.0 * _['sign']),
              Right((_) => 7.0 * _['sign']),
              RunMacro(
                  'fern', (_) => {'size': _['size'] - 1.0, 'sign': _['sign']}),
              Left((_) => 7.0 * _['sign']),
              Back((_) => _['size'] * 2.0),
            ])
          ]),
          Back((_) => 150.0),
          PenDown(),
          RunMacro('fern', (_) => {'size': 25.0, 'sign': 1.0}),
          PenUp(),
        ],
      ),
    );
  }
}
