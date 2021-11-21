import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class RedSquarePage extends StatefulWidget {
  @override
  _RedSquarePageState createState() => _RedSquarePageState();
}

class _RedSquarePageState extends State<RedSquarePage> {
  @override
  Widget build(BuildContext context) {
    var commands = [
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
      appBar: AppBar(title: Text('Red Suqares'), actions: <Widget>[
        TextButton(
          onPressed: () => setState(() {}),
          child: Text('Run', style: TextStyle(color: Colors.white)),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'http://www.logointerpreter.com/view-program.php?user=Josefminecraft&program=77%20red%20sqares'),
            ),
            AnimatedTurtleView(
                child: Container(width: double.infinity, height: 400.0),
                commands: commands),
          ],
        ),
      ),
    );
  }
}
