import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class RedSquarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
                'http://www.logointerpreter.com/view-program.php?user=Josefminecraft&program=77%20red%20sqares'),
            TurtleView(
              child: Container(
                width: double.infinity,
                height: 400.0,
              ),
              commands: [
                PenDown(),
                SetStrokeWidth((_) => 1),
                SetColor((_) => Colors.red),
                Repeat((_) => 77, [
                  Repeat((_) => 4, [
                    Forward((_) => 100.0),
                    Right((_) => 90),
                  ]),
                  Right((_) => 5),
                ]),
                PenUp(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
