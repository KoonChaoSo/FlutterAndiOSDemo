//{
// "_id":"5be14edb9d21223dd50660f8",
// "createdAt":"2018-11-06T08:20:43.656Z",
// "desc":"2018-11-06",
// "publishedAt":"2018-11-06T00:00:00.0Z",
// "source":"web",
// "type":"\u798f\u5229",
// "url":"https://ws1.sinaimg.cn/large/0065oQSqgy1fwyf0wr8hhj30ie0nhq6p.jpg",
// "used":true,
// "who":"lijinshanmx"
// }
class GankWelfare {
  String _id;
  String createdAt;
  String desc;
  List<dynamic> images;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  GankWelfare(this._id, this.createdAt, this.desc, this.images,
      this.publishedAt, this.source, this.type, this.url, this.used, this.who);

  GankWelfare.fromJson(Map<String, dynamic> json) {
    this._id = json['_id'];
    this.createdAt = json['createdAt'];
    this.desc = json['desc'];
    this.images = json['images'];
    this.publishedAt = json['publishedAt'];
    this.source = json['source'];
    this.type = json['type'];
    this.url = json['url'];
    this.used = json['used'];
    this.who = json['who'];
  }

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'createdAt': createdAt,
        'desc': desc,
        'images': images,
        'publishedAt': publishedAt,
        'source': source,
        'type': type,
        'url': url,
        'used': used,
        'who': who,
      };
}
