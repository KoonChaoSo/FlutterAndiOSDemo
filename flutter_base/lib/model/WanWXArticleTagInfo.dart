// "tags":[{"name":"公众号","url":"/wxarticle/list/409/1"}]

class WanWXArticleTagInfo {
  String name;
  String url;

  WanWXArticleTagInfo(this.name, this.url);

  WanWXArticleTagInfo.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.url = json['url'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}
