import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  Widget build(BuildContext context) {
    var commands = [
      PenDown(),
      SetColor((_) => Color(0xffff9933)),
      SetStrokeWidth((_) => 2),
      Repeat((_) => 20, [
        Repeat((_) => 180, [Forward((_) => 25.0), Right((_) => 20)]),
        Right((_) => 18),
      ]),
      PenUp(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Logo'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => setState(() {}),
            child: Text('Run'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'See https://en.wikipedia.org/wiki/Logo_(programming_language)',
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedTurtleView(
              animationDuration: Duration(seconds: 3),
              child: Container(
                width: double.infinity,
                height: 400,
              ),
              commands: commands,
            ),
          ],
        ),
      ),
    );
  }
}
