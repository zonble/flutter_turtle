import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  Widget build(BuildContext context) {
    final commands = [
      PenDown(),
      SetColor((_) => const Color(0xffff9933)),
      SetStrokeWidth((_) => 2),
      Repeat((_) => 20, [
        Repeat((_) => 180, [Forward((_) => 25.0), Right((_) => 20)]),
        Right((_) => 18),
      ]),
      PenUp(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Logo'), actions: <Widget>[
        TextButton(
          onPressed: () => setState(() {}),
          child: const Text('Run', style: TextStyle(color: Colors.white)),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'See https://en.wikipedia.org/wiki/Logo_(programming_language)',
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedTurtleView(
              animationDuration: const Duration(seconds: 3),
              child: const SizedBox(
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
