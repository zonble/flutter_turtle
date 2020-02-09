import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class Clock2Page extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<Clock2Page> {
  DateTime _now;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute != _now.minute) {
        setState(() => _now = now);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hour = (_now.hour % 12);
    var min = _now.minute;

    return Scaffold(
      appBar: AppBar(
        title: Text('Clock'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => setState(() {
              final now = DateTime.now();
              _now = now;
            }),
            child: Text('Run'),
          )
        ],
      ),
      body: AnimatedTurtleView(
        animationDuration: Duration(seconds: 1),
        child: Container(),
        commands: [
          SetStrokeWidth((_) => 2),
          Repeat((_) => min + 1, [
            PenDown(),
            SetColor((_) =>
                Colors.black.withOpacity(_['repcount'].toDouble() / (min + 1))),
            Forward((_) => 100 / (min + 1).toDouble() * _['repcount'] + 50),
            PenUp(),
            Back((_) => 100 / (min + 1).toDouble() * _['repcount'] + 50),
            Right((_) => 6),
          ]),
          ResetHeading(),
          SetStrokeWidth((_) => 20),
          Repeat((_) => hour + 1, [
            PenDown(),
            SetColor((_) =>
                Colors.red.withOpacity(_['repcount'].toDouble() / (hour + 1))),
            Forward((_) => 100 / (hour + 1).toDouble() * _['repcount']),
            PenUp(),
            Back((_) => 100 / (hour + 1).toDouble() * _['repcount']),
            Right((_) => 30),
          ]),
          ResetHeading(),
          SetColor((_) => Colors.black),
          SetStrokeWidth((_) => 4),
          Repeat((_) => 12, [
            Right((_) => 30),
            Forward((_) => 150),
            PenDown(),
            Forward((_) => 10),
            PenUp(),
            Forward((_) => 40),
            Back((_) => 200),
          ]),
        ],
      ),
    );
  }
}
