import 'package:flutter/material.dart';
import 'package:flutter_turtle_example/pages/fern_page.dart';

import 'pages/flower_page.dart';
import 'pages/logo_page.dart';
import 'pages/red_square_page.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Center(
              child: Wrap(
                children: <Widget>[
                  MyTile(
                    title: 'Logo',
                    image: 'images/1.png',
                    builder: (_) => LogoPage(),
                  ),
                  MyTile(
                    title: 'Star',
                    image: 'images/2.png',
                    builder: (_) => StarPage(),
                  ),
                  MyTile(
                      title: 'Flower',
                      image: 'images/3.png',
                      builder: (_) => FlowerPage()),
                  MyTile(
                      title: 'Red Suqares',
                      image: 'images/4.png',
                      builder: (_) => RedSquarePage()),
                  MyTile(
                    title: 'Tree',
                    image: 'images/5.png',
                    builder: (_) => TreePage(),
                  ),
                  MyTile(
                    title: 'Fern',
                    image: 'images/6.png',
                    builder: (_) => FernPage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  final String title;
  final String image;
  final WidgetBuilder builder;

  const MyTile({
    Key key,
    this.title,
    this.builder,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: builder)),
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
