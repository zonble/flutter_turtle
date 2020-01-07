import 'package:flutter/material.dart';
import 'package:flutter_turtle_example/tree_page.dart';

import 'logo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
          ListTile(
            title: Text('Logo'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LogoPage()));
            },
          ),
          ListTile(
            title: Text('Tree'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => TreePage()));
            },
          ),
        ],
      ),
    );
  }
}
