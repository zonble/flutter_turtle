import 'package:flutter/material.dart';
import 'package:flutter_turtle_example/pages/fern_page.dart';

import 'pages/flower_page.dart';
import 'pages/logo_page.dart';
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
      body: ListView(
        children: <Widget>[
          MyTile(title: 'Logo', builder: (_) => LogoPage()),
          MyTile(title: 'Star', builder: (_) => StarPage()),
          MyTile(title: 'Flower', builder: (_) => FlowerPage()),
          MyTile(title: 'Tree', builder: (_) => TreePage()),
          MyTile(title: 'Fern', builder: (_) => FernPage()),
        ],
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  final String title;
  final WidgetBuilder builder;

  const MyTile({
    Key key,
    this.title,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: builder));
        },
      );
}
