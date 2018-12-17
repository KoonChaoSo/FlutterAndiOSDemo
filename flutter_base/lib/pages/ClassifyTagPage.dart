import 'package:flutter/material.dart';
import 'package:flutter_base/pages/ClassifyDetailPages.dart';

class ClassifyTabPage {
  ClassifyTabPage({this.icon, this.text, this.detailPage});

  final IconData icon;
  final String text;
  final ClassifyDetailComponent detailPage;

  List<ClassifyTabPage> initClassify() {
    // 存储所有页面的列表
    List<ClassifyTabPage> _allPages = <ClassifyTabPage>[
      new ClassifyTabPage(
          text: "Android",
          detailPage: new ClassifyDetailComponent(
            type: ('Android'),
          )),
      new ClassifyTabPage(
          text: "iOS",
          detailPage: new ClassifyDetailComponent(
            type: ('iOS'),
          )),
      new ClassifyTabPage(
          text: "前端",
          detailPage: new ClassifyDetailComponent(
            type: ('前端'),
          )),
      new ClassifyTabPage(
          text: "拓展资源",
          detailPage: new ClassifyDetailComponent(
            type: ('拓展资源'),
          )),
      new ClassifyTabPage(
          text: "瞎推荐",
          detailPage: new ClassifyDetailComponent(
            type: ('瞎推荐'),
          )),
      new ClassifyTabPage(
          text: "App",
          detailPage: new ClassifyDetailComponent(
            type: ('App'),
          )),
      new ClassifyTabPage(
          text: "休息视频",
          detailPage: new ClassifyDetailComponent(
            type: ('休息视频'),
          )),
    ];
    return _allPages;
  }
}
