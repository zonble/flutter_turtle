import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: TurtleView(
        child: Container(),
        commands: [
          PenDown(),
          SetColor(() => Color(0xffff9933)),
          Repeat(() => 20, [
            Repeat(() => 180, [
              Forward(() => 25.0),
              Right(() => 20),
            ]),
            Right(() => 18),
          ]),
          PenUp(),
        ],
      ),
    );
  }
}
