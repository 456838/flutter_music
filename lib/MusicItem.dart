class MusicItem {

  String result;
  int code;
  List<Data> data;

  MusicItem.fromJsonMap(Map<String, dynamic> map): 
    result = map["result"],
    code = map["code"],
    data = List<Data>.from(map["data"].map((it) => Data.fromJsonMap(it)));

}

class Data {

  String id;
  String name;
  int time;
  String singer;
  String url;
  String pic;
  String lrc;

  Data.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        name = map["name"],
        time = map["time"],
        singer = map["singer"],
        url = map["url"],
        pic = map["pic"],
        lrc = map["lrc"];
}