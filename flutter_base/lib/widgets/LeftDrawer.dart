import 'package:flutter/material.dart';
import 'package:flutter_base/base/BaseApplication.dart';
import 'package:flutter_base/contants/RounterContants.dart';
import 'package:flutter_base/utils/Utf8Utils.dart';

class BaseDrawer extends StatelessWidget {
  // 菜单文本前面的图标大小
  static const double IMAGE_ICON_WIDTH = 30.0;
  // 菜单后面的箭头的图标大小
  static const double ARROW_ICON_WIDTH = 16.0;
  // 菜单后面的箭头图片
  var rightArrowIcon = new Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );
  // 菜单的文本
  List menuTitles = ['A', 'B', 'C', 'D'];
  // 菜单文本前面的图标
  List menuIcons = [
    './images/v75_heart.png',
    './images/v77_cake.png',
    './images/v78_lightning.png',
    './images/v79_bomb.png'
  ];
  // 菜单文本的样式
  TextStyle menuStyle = new TextStyle(
    fontSize: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 304.0),
      child: new Material(
        elevation: 16.0,
        child: new Container(
          decoration: new BoxDecoration(
            color: const Color(0xFFFFFFFF),
          ),
          child: new ListView.builder(
            itemCount: menuTitles.length * 2 + 1,
            itemBuilder: renderRow,
          ),
        ),
      ),
    );
  }

  Widget getIconImage(path) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 6.0, 0.0),
      child: new Image.asset(path, width: 28.0, height: 28.0),
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      // render cover image
      var img = new Image.asset(
        './images/v75_heart.png',
        width: 304.0,
        height: 304.0,
      );
      return new Container(
        width: 304.0,
        height: 304.0,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        child: img,
      );
    }
    // 舍去之前的封面图
    index -= 1;
    // 如果是奇数则渲染分割线
    if (index.isOdd) {
      return new Divider();
    }
    // 偶数，就除2取整，然后渲染菜单item
    index = index ~/ 2;
    // 菜单item组件
    var listItemContent = new Padding(
      // 设置item的外边距
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      // Row组件构成item的一行
      child: new Row(
        children: <Widget>[
          // 菜单item的图标
          getIconImage(menuIcons[index]),
          // 菜单item的文本，需要
          new Expanded(
            child: new Text(
              menuTitles[index],
              style: menuStyle,
            )
          ),
          rightArrowIcon
        ],
      ),
    );

    return new InkWell(
      child: listItemContent,
      onTap: () {
        switch (index) {
          case 0:
              Application.router.navigateTo(context, Routes.root);
            break;
          case 1:
              Application.router.navigateTo(context, Routes.demoSimple);
            break;
          case 2:
            String title = "webview";
            String url = Utf8Utils.lineToASC("https://v.douyin.com/RPTYPR/");
            Application.router.navigateTo(context,
                Routes.webLink + "?" + Routes.webTitle + "=$title&" + Routes.webUrl + "=$url");
            break;
          case 3:
            String url = Utf8Utils.lineToASC("https://ws1.sinaimg.cn/large/0065oQSqly1fubd0blrbuj30ia0qp0yi.jpg");
            Application.router.navigateTo(context,
                Routes.photoLink + "?" + Routes.webUrl + "=$url");
            break;
        }
      },
    );
  }
}