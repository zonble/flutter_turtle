import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class LogoControllerPage extends StatefulWidget {
  @override
  _LogoControllerPageState createState() => _LogoControllerPageState();
}

class _LogoControllerPageState extends State<LogoControllerPage>
    with SingleTickerProviderStateMixin {
  double _value = 0.0;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 0.0,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
        appBar: AppBar(title: Text('Logo')),
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
                Slider(
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                      _controller?.value = value;
                    });
                  },
                ),
                ControllableTurtleView(
                  controller: _controller!,
                  child: Container(
                    width: double.infinity,
                    height: 400,
                  ),
                  commands: commands,
                ),
              ]),
        ));
  }
}
