import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class RedSquarePage extends StatefulWidget {
  const RedSquarePage({Key? key}) : super(key: key);

  @override
  _RedSquarePageState createState() => _RedSquarePageState();
}

class _RedSquarePageState extends State<RedSquarePage> {
  @override
  Widget build(BuildContext context) {
    final commands = [
      PenDown(),
      SetStrokeWidth((_) => 1),
      SetColor((_) => Colors.red),
      Repeat((_) => 77, [
        Repeat((_) => 4, [Forward((_) => 100.0), Right((_) => 90)]),
        Right((_) => 5)
      ]),
      PenUp(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Red Suqares'), actions: <Widget>[
        TextButton(
          onPressed: () => setState(() {}),
          child: const Text('Run', style: TextStyle(color: Colors.white)),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  'http://www.logointerpreter.com/view-program.php?user=Josefminecraft&program=77%20red%20sqares'),
            ),
            AnimatedTurtleView(
                child: const SizedBox(width: double.infinity, height: 400.0),
                commands: commands),
          ],
        ),
      ),
    );
  }
}
