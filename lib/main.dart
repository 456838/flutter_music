import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/MusicItem.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_music/demo/MusicSearchResultDemo.dart';

void main() {
  runApp(MusicSearchResultDemo());
}

class MyApp extends StatelessWidget {
  List list = List.generate(100, (i) => "haha$i");

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: ListView.builder(
            itemBuilder: _renderRow,
            itemCount: list.length,
          ),
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return ListTile(
      title: Text(list[index]),
    );
  }
}

class MyAppOld extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: '音乐引擎'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Data> mData = new List();
  final TextEditingController _controller = new TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
//        leading: IconButton(
//          icon: Icon(Icons.search),
//          tooltip: "searchAction",
//          onPressed: () => searchMusic(_controller.text),
//        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "searchAction",
            onPressed: () => searchMusic(_controller.text),
          )
        ],
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return ListTile(
      title: Text("hello"),
    );
  }

  Widget itemView(BuildContext context, int index) {
    Data model = this.mData[index];
    //设置分割线
    if (index.isOdd) return new Divider(height: 2.0);
    return new Container(
        color: Color.fromARGB(0x22, 0x49, 0xa9, 0x8d),
        child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text('${model.name}:${model.singer}:${model.time}日',
                            style: new TextStyle(fontSize: 15.0)),
                        new Text('(${model.lrc})',
                            style: new TextStyle(fontSize: 15.0)),
                      ],
                    ),
                    new Center(
                      heightFactor: 6.0,
                      child: new Text("${model.url}",
                          style: new TextStyle(fontSize: 17.0)),
                    )
                  ],
                ))));
  }

  searchMusic(String text) async {
    String keyword = "123木头人";
    String url = "https://api.bzqll.com/music/tencent/search?key=579621905&s=" +
        keyword +
        "&limit=100&offset=0&type=song";
    var responseBody;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
    } else {
      print("error");
    }
    var item = MusicItem.fromJsonMap(responseBody);
//    mData.addAll(item.data);
    setState(() {
      mData.addAll(item.data);
      print("[setState]:${item.result}");
    });
    print('${item.data.toString()}');
  }
}
