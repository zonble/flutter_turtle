import 'package:flutter/material.dart';
import 'package:flutter_turtle_example/pages/lsystem_page.dart';

import 'pages/clock2_page.dart';
import 'pages/clock_page.dart';
import 'pages/fern_page.dart';
import 'pages/flower_page.dart';
import 'pages/label.dart';
import 'pages/logo_controller_page.dart';
import 'pages/logo_page.dart';
import 'pages/red_square_page.dart';
import 'pages/snowflake_page.dart';
import 'pages/spiral2page.dart';
import 'pages/spiralpage.dart';
import 'pages/star_page.dart';
import 'pages/tree_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Examples'),
      routes: {
        'label': (_) => const LabelPage(),
        'logo': (_) => const LogoPage(),
        'logo_controller': (_) => const LogoControllerPage(),
        'star': (_) => const StarPage(),
        'flower': (_) => const FlowerPage(),
        'red_square': (_) => const RedSquarePage(),
        'tree': (_) => const TreePage(),
        'fern': (_) => const FernPage(),
        'clock1': (_) => const ClockPage(),
        'clock2': (_) => const Clock2Page(),
        'spiral': (_) => const SpiralPage(),
        'spiral2': (_) => const Spiral2Page(),
        'snowflake': (_) => const SnowflakePage(),
        'lsystem_plant': (_) => const LSystemPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var tiles = <Widget>[
      const MyTile(title: 'Logo', image: 'images/1.png', pageName: 'logo'),
      const MyTile(
          title: 'Logo with Controller',
          image: 'images/1.png',
          pageName: 'logo_controller'),
      const MyTile(title: 'Star', image: 'images/2.png', pageName: 'star'),
      const MyTile(title: 'Flower', image: 'images/3.png', pageName: 'flower'),
      const MyTile(
          title: 'Red Suqares', image: 'images/4.png', pageName: 'red_square'),
      const MyTile(title: 'Tree', image: 'images/5.png', pageName: 'tree'),
      const MyTile(title: 'Fern', image: 'images/6.png', pageName: 'fern'),
      const MyTile(title: 'Label', image: 'images/7.png', pageName: 'label'),
      const MyTile(title: 'Clock', image: 'images/8.png', pageName: 'clock1'),
      const MyTile(title: 'Clock', image: 'images/9.png', pageName: 'clock2'),
      const MyTile(title: 'Spiral', image: 'images/10.png', pageName: 'spiral'),
      const MyTile(
          title: 'Spiral', image: 'images/11.png', pageName: 'spiral2'),
      const MyTile(
          title: 'Snowflake', image: 'images/12.png', pageName: 'snowflake'),
      const MyTile(
        title: 'L-System Plant',
        pageName: 'lsystem_plant',
        image: 'images/13.png',
      ),
    ];
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Center(
                      child: Wrap(children: tiles),
                    )))));
  }
}

class MyTile extends StatelessWidget {
  final String title;
  final String pageName;
  final String image;

  const MyTile({
    super.key,
    required this.title,
    required this.pageName,
    required this.image,
  });

  @override
  Widget build(BuildContext context) => Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(pageName),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Image.asset(image)),
                const SizedBox(height: 10),
                Text(title),
                const SizedBox(height: 10),
              ]))));
}
