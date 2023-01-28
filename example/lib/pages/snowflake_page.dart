import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class SnowflakePage extends StatefulWidget {
  @override
  _SnowflakePageState createState() => _SnowflakePageState();
}

class _SnowflakePageState extends State<SnowflakePage> {
  @override
  Widget build(BuildContext context) {
    var commands = [
      SetMacro('snowflake', [
        IfElse((_) => _['long_side'] <= 10, [
          PenDown(),
          Forward((_) => _['long_side']),
          PenUp(),
        ], [
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
          Left((_) => 60),
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
          Right((_) => 120),
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
          Left((_) => 60),
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
        ])
      ]),
      SetColor((_) => Colors.blue),
      PenUp(),
      Left((_) => 90),
      Forward((_) => 300.0 / 3),
      Right((_) => 90),
      PenDown(),
      Repeat((_) => 3, [
        Right((_) => 120),
        RunMacro('snowflake', (_) => {'long_side': 300.0}),
        Forward((_) => 300),
      ]),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Snowflake'), actions: <Widget>[
        TextButton(
          onPressed: () => setState(() {}),
          child: Text('Run', style: TextStyle(color: Colors.white)),
        )
      ]),
      body: AnimatedTurtleView(
          child: Container(width: double.infinity, height: 300),
          commands: commands),
    );
  }
}
