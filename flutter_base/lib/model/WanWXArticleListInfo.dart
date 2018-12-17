//{
// "apkLink":"",
// "author":"郭霖",
// "chapterId":409,
// "chapterName":"郭霖",
// "collect":false,
// "courseId":13,
// "desc":"",
// "envelopePic":"",
// "fresh":false,
// "id":7492,
// "link":"https://mp.weixin.qq.com/s/It8xSD_XOc7ceClR12ww2Q",
// "niceDate":"2018-11-09",
// "origin":"",
// "projectLink":"",
// "publishTime":1541692800000,
// "superChapterId":408,
// "superChapterName":"公众号",
// "tags":[{"name":"公众号","url":"/wxarticle/list/409/1"}],
// "title":"使用Android Studio查看并调试Android源码",
// "type":0,
// "userId":-1,
// "visible":1,
// "zan":0
// }

import 'package:flutter_base/model/WanWXArticleTagInfo.dart';

class WanWXArticleListInfo {
  String apkLink;
  String author;
  String chapterId;
  String chapterName;
  bool collect;
  String courseId;
  String desc;
  String envelopePic;
  bool fresh;
  String id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  String publishTime;
  String superChapterId;
  String superChapterName;
  WanWXArticleTagInfo tags;
  String title;
  String type;
  String userId;
  String visible;
  String zan;

  WanWXArticleListInfo(
      this.apkLink,
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.projectLink,
      this.publishTime,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  WanWXArticleListInfo.fromJson(Map<String, dynamic> json) {
    this.apkLink = json['apkLink'];
    this.author = json['author'];
    this.chapterId = json['chapterId'];
    this.chapterName = json['chapterName'];
    this.collect = json['collect'];
    this.courseId = json['courseId'];
    this.desc = json['desc'];
    this.envelopePic = json['envelopePic'];
    this.fresh = json['fresh'];
    this.id = json['id'];
    this.link = json['link'];
    this.niceDate = json['niceDate'];
    this.origin = json['origin'];
    this.projectLink = json['projectLink'];
    this.publishTime = json['publishTime'];
    this.superChapterId = json['superChapterId'];
    this.superChapterName = json['superChapterName'];
    this.tags = json['tags'];
    this.title = json['title'];
    this.type = json['type'];
    this.userId = json['userId'];
    this.visible = json['visible'];
    this.zan = json['zan'];
  }

  Map<String, dynamic> toJson() => {
        'apkLink': apkLink,
        'author': author,
        'chapterId': chapterId,
        'chapterName': chapterName,
        'collect': collect,
        'courseId': courseId,
        'desc': desc,
        'envelopePic': envelopePic,
        'fresh': fresh,
        'id': id,
        'link': link,
        'niceDate': niceDate,
        'origin': origin,
        'projectLink': projectLink,
        'publishTime': publishTime,
        'superChapterId': superChapterId,
        'superChapterName': superChapterName,
        'tags': tags,
        'title': title,
        'type': type,
        'userId': userId,
        'visible': visible,
        'zan': zan,
      };
}
