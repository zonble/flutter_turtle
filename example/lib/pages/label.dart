import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

/// An example from https://www.calormen.com/jslogo/
class LabelPage extends StatefulWidget {
  const LabelPage({super.key});

  @override
  State<LabelPage> createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Label'), actions: <Widget>[
          TextButton(
            onPressed: () => setState(() {}),
            child: const Text('Run', style: TextStyle(color: Colors.white)),
          )
        ]),
        body: ClipRect(
            child: AnimatedTurtleView(
          animationDuration: const Duration(seconds: 1),
          commands: [
            Repeat((_) => 144, [
              SetLabelHeight((_) => _['repcount'].toDouble()),
              PenUp(),
              Forward((_) => (_['repcount'] * _['repcount']).toDouble() / 30.0),
              Label((_) => 'Turtle'),
              Back((_) => (_['repcount'] * _['repcount']).toDouble() / 30.0),
              PenDown(),
              Right((_) => 10),
            ]),
          ],
          child: Container(),
        )));
  }
}
