import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

/// An example from https://www.calormen.com/jslogo/
class StarPage extends StatefulWidget {
  const StarPage({super.key});

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Star'), actions: <Widget>[
          TextButton(
            onPressed: () => setState(() {}),
            child: const Text('Run', style: TextStyle(color: Colors.white)),
          )
        ]),
        body: AnimatedTurtleView(
          animationDuration: const Duration(seconds: 1),
          commands: [
            PenDown(),
            SetColor((_) => Colors.red),
            SetStrokeWidth((_) => 2),
            Repeat((_) => 5, [Forward((_) => 200), Right((_) => 144)]),
            PenUp(),
          ],
          child: Container(),
        ));
  }
}
