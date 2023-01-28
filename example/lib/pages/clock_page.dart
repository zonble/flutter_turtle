import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  DateTime? _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute != _now?.minute) {
        setState(() => _now = now);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hour = (_now?.hour ?? 0 % 12).toDouble();
    var min = _now?.minute.toDouble() ?? 0;
    hour += min / 60;

    return Scaffold(
      appBar: AppBar(
        title: Text('Clock'),
        actions: <Widget>[
          TextButton(
            onPressed: () => setState(() {
              final now = DateTime.now();
              _now = now;
            }),
            child: Text('Run', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: AnimatedTurtleView(
        animationDuration: Duration(seconds: 1),
        child: Container(),
        commands: [
          PenDown(),
          SetStrokeWidth((_) => 5),
          Right((_) => hour * 30),
          Forward((_) => 70),
          PenUp(),
          Back((_) => 70),
          ResetHeading(),
          PenDown(),
          SetStrokeWidth((_) => 2),
          Right((_) => min * 6),
          Forward((_) => 120),
          PenUp(),
          Back((_) => 120),
          ResetHeading(),
          Repeat((_) => 12, [
            Right((_) => 30),
            Forward((_) => 150),
            PenDown(),
            Forward((_) => 10),
            PenUp(),
            Forward((_) => 40),
            Right((_) => 90),
            Back((_) => 10),
            SetLabelHeight((_) => _['repcount'].toDouble() + 20),
            Label((_) => '${_['repcount']}'),
            Forward((_) => 10),
            Left((_) => 90),
            Back((_) => 200),
          ]),
        ],
      ),
    );
  }
}
