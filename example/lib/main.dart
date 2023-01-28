import 'package:flutter/material.dart';

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Examples'),
      routes: {
        'label': (_) => LabelPage(),
        'logo': (_) => LogoPage(),
        'logo_controller': (_) => LogoControllerPage(),
        'star': (_) => StarPage(),
        'flower': (_) => FlowerPage(),
        'red_square': (_) => RedSquarePage(),
        'tree': (_) => TreePage(),
        'fern': (_) => FernPage(),
        'clock1': (_) => ClockPage(),
        'clock2': (_) => Clock2Page(),
        'spiral': (_) => SpiralPage(),
        'spiral2': (_) => Spiral2Page(),
        'snowflake': (_) => SnowflakePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var tiles = <Widget>[
      MyTile(title: 'Logo', image: 'images/1.png', pageName: 'logo'),
      MyTile(
          title: 'Logo with Controller',
          image: 'images/1.png',
          pageName: 'logo_controller'),
      MyTile(title: 'Star', image: 'images/2.png', pageName: 'star'),
      MyTile(title: 'Flower', image: 'images/3.png', pageName: 'flower'),
      MyTile(
          title: 'Red Suqares', image: 'images/4.png', pageName: 'red_square'),
      MyTile(title: 'Tree', image: 'images/5.png', pageName: 'tree'),
      MyTile(title: 'Fern', image: 'images/6.png', pageName: 'fern'),
      MyTile(title: 'Label', image: 'images/7.png', pageName: 'label'),
      MyTile(title: 'Clock', image: 'images/8.png', pageName: 'clock1'),
      MyTile(title: 'Clock', image: 'images/9.png', pageName: 'clock2'),
      MyTile(title: 'Spiral', image: 'images/10.png', pageName: 'spiral'),
      MyTile(title: 'Spiral', image: 'images/11.png', pageName: 'spiral2'),
      MyTile(title: 'Snowflake', image: 'images/12.png', pageName: 'snowflake'),
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(this.pageName),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Image.asset(this.image)),
                SizedBox(height: 10),
                Text(title),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
}
