import 'package:flutter/material.dart';

///一个固定高度的行，通常包含一些文本，以及一个行前或行尾图标。
class ListTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ListTileDemo",
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('AppBar-ListTileDemo'),
        ),
        body: new MyCard(),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyCardState();
  }
}

class MyCardState extends State<MyCard> {
  var _throwShotAway = false;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new ListTile(
        title: new Text("newsalton"),
        subtitle: new Text("newsalton@163.com"),
        leading: new Icon(
          Icons.email,
          color: Colors.blueAccent,
        ),
        trailing: new Checkbox(
            value: _throwShotAway,
            onChanged: (bool newValue) {
              setState(() {
                _throwShotAway = newValue;
              });
            }),
      ),
    );
  }
}
