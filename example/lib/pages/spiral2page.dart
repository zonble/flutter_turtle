import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class Spiral2Page extends StatefulWidget {
  Spiral2Page({Key? key}) : super(key: key);

  @override
  _Spiral2PageState createState() => _Spiral2PageState();
}

class _Spiral2PageState extends State<Spiral2Page> {
  @override
  Widget build(BuildContext context) {
    var commands = [
      SetMacro('rect', [
        Forward((_) => _['l']),
        Left((_) => 90.0),
        PenDown(),
        Forward((_) => _['l']),
        Repeat((_) => 3, [Left((_) => 90.0), Forward((_) => _['l'] * 2)]),
        Left((_) => 90.0),
        Forward((_) => _['l']),
        PenUp(),
      ]),
      Repeat((_) => 50, [
        Left((_) => 2),
        RunMacro('rect', (_) => {'l': 8.0 * _['repcount']}),
      ])
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
            commands: commands),
      ),
    );
  }
}
