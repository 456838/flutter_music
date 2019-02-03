import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/MusicItem.dart';
import 'package:flutter_music/event/event_bus.dart';

class MusicSearchResultDemo extends StatelessWidget {
  final eventBus = new EventBus();

  MusicSearchResultDemo() {
    ApplicationEvent.event = eventBus;
  }

  final TextEditingController _controller =
      new TextEditingController.fromValue(TextEditingValue(
    // 设置内容
    text: "生僻字",
    // 保持光标在最后
    selection: TextSelection.fromPosition(
        TextPosition(affinity: TextAffinity.downstream, offset: "生僻字".length)),
  ));

  @override
  Widget build(BuildContext context) {
    print("[eventbus] register");
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      home: new Scaffold(
        body: new SearchResultCard(),
        appBar: AppBar(
          title: new TextField(
            decoration: InputDecoration(labelText: "音乐名称"),
            controller: _controller,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "searchAction",
              onPressed: () => searchMusic(_controller.text),
            )
          ],
        ),
      ),
    );
  }
}

searchMusic(String keyword) async {
//  keyword="123木头人";
  print("[searchMusic] keyword:$keyword");
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
  MusicItem item = MusicItem.fromJsonMap(responseBody);
  ApplicationEvent.event.fire(item);
  print('[searchMusic] fire action: $responseBody');
}

class SearchResultCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SearchResultCardState();
  }
}

class SearchResultCardState extends State<SearchResultCard> {
  List<Data> list = new List();

  SearchResultCardState() {}

  @override
  void initState() {
    super.initState();
    ApplicationEvent.event.on<MusicItem>().listen((event) {
      updateList(event);
      print("[eventbus] onReceive");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: list.length, itemBuilder: _itemBuilder);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    //设置分割线
//    if (index.isOdd) return new Divider();
    Data data = list[index];
    return new ListTile(
        leading: new Image(
            image: new NetworkImage(data.pic),
            width: 60,
            height: 60,
            fit: BoxFit.cover),
        title: new Text(data.name),
        subtitle: new Text(data.singer),
        trailing: MaterialButton(
            child: new Text("下载"), onPressed: () => _downloadTask(data)));
  }

  updateList(MusicItem item) {
    setState(() {
      list.addAll(item.data);
    });
  }

  _downloadTask(Data item) async {
    print("[_downloadTask]");
    Dio dio = new Dio();
    await dio.download(item.url, "./${item.name}-${item.singer}",
        onProgress: (received, total) {
          print("total:$total,received:$received");
        });
//    dio.download("https://www.google.com/", "./xx.html");
  }
}
