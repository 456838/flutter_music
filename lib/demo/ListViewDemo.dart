import 'package:flutter/material.dart';

/// Scaffold Material Design布局结构的基本实现。此类提供了用于显示drawer、snackbar和底部sheet的API。
class ListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ListViewDemo",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("ListViewDemo"),
        ),
        body: new Center(
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _getContainer('Maps', Icons.map),
              _getContainer('phone', Icons.phone),
              _getContainer('Maps', Icons.map),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getContainer(String text, IconData icon) {
    return new Container(
      width: 160,
      child: new ListTile(
        trailing: new Icon(icon),
        title: new Text(text),
      ),
    );
  }
}
