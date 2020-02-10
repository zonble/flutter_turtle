import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

/// An example from https://www.calormen.com/jslogo/
class StarPage extends StatefulWidget {
  @override
  _StarPageState createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => setState(() {}),
            child: Text('Run'),
          )
        ],
      ),
      body: AnimatedTurtleView(
        animationDuration: Duration(seconds: 1),
        child: Container(),
        commands: [
          PenDown(),
          SetColor((_) => Colors.red),
          SetStrokeWidth((_) => 2),
          Repeat((_) => 5, [Forward((_) => 200), Right((_) => 144)]),
          PenUp(),
        ],
      ),
    );
  }
}
