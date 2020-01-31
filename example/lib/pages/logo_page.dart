import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logo')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'See https://en.wikipedia.org/wiki/Logo_(programming_language)',
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
            AnimatedTurtleView(
              child: Container(
                width: double.infinity,
                height: 400,
              ),
              commands: [
                PenDown(),
                SetColor((_) => Color(0xffff9933)),
                SetStrokeWidth((_) => 2),
                Repeat((_) => 20, [
                  Repeat((_) => 180, [
                    Forward((_) => 25.0),
                    Right((_) => 20),
                  ]),
                  Right((_) => 18),
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
