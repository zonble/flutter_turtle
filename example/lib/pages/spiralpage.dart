import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class SpiralPage extends StatefulWidget {
  const SpiralPage({super.key});

  @override
  State<SpiralPage> createState() => _SpiralState();
}

class _SpiralState extends State<SpiralPage> {
  @override
  Widget build(BuildContext context) {
    final commands = [
      PenDown(),
      SetColor((_) => const Color(0xffff9933)),
      SetStrokeWidth((_) => 2),
      Repeat((_) => 200,
          [Left((_) => 60), Forward((_) => _['repcount'].toDouble() * 2)]),
      PenUp(),
    ];

    return Scaffold(
        appBar: AppBar(title: const Text('Spiral'), actions: <Widget>[
          TextButton(
            onPressed: () => setState(() {}),
            child: const Text('Run', style: TextStyle(color: Colors.white)),
          )
        ]),
        body: ClipRect(
            child: AnimatedTurtleView(
          animationDuration: const Duration(seconds: 3),
          commands: commands,
          child: Container(),
        )));
  }
}
