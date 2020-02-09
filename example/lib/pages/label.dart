import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

/// An example from https://www.calormen.com/jslogo/
class LabelPage extends StatefulWidget {
  @override
  _LabelPageState createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Label'),
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
          animationDuration: Duration(seconds: 1),
          child: Container(),
          commands: [
            Repeat((_) => 144, [
              SetLabelHeight((_) => _['repcount'].toDouble()),
              PenUp(),
              Forward((_) => (_['repcount'] * _['repcount']).toDouble() / 30.0),
              Label((_) => 'Turtle'),
              Back((_) => (_['repcount'] * _['repcount']).toDouble() / 30.0),
              PenDown(),
              Right((_) => 10),
            ]),
          ],
        ),
      ),
    );
  }
}
