
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
