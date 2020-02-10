import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class SpiralPage extends StatefulWidget {
  @override
  _SpiralState createState() => _SpiralState();
}

class _SpiralState extends State<SpiralPage> {
  @override
  Widget build(BuildContext context) {
    var commands = [
      PenDown(),
      SetColor((_) => Color(0xffff9933)),
      SetStrokeWidth((_) => 2),
      Repeat((_) => 200,
          [Left((_) => 60), Forward((_) => _['repcount'].toDouble() * 2)]),
      PenUp(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Spiral'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => setState(() {}),
            child: Text('Run'),
          )
        ],
      ),
      body: ClipRect(
        child: AnimatedTurtleView(
          animationDuration: Duration(seconds: 3),
          child: Container(),
          commands: commands,
        ),
      ),
    );
  }
}
