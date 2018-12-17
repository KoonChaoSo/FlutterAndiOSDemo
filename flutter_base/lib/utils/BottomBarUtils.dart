import 'package:flutter/material.dart';
import 'package:flutter_base/pages/ClassifyPages.dart';
import 'package:flutter_base/pages/WXArticlePages.dart';
import 'package:flutter_base/pages/WelfareDoubleListPages.dart';
import 'package:flutter_base/pages/WelfarePages.dart';

// BottomBar控制类
class BottomBarUtils {
  static var tabImages;
  static var appBarTitles = ['首页', '发现', '福利', '我的'];
  static var _body;
  static int _tabIndex = 0;
  static final tabTextStyleNormal =
      new TextStyle(color: const Color(0xff969696));
  static final tabTextStyleSelected =
      new TextStyle(color: const Color(0xff63ca6c));

  static IndexedStack getBody() {
    return _body;
  }

  static int getTabIndex() {
    return _tabIndex;
  }

  static void setTabIndex(int index) {
    _tabIndex = index;
  }

  static Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  static Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  static Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  static TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  static void initData() {
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/v84_money.png'),
          getTabImage('images/v84_money.png')
        ],
        [
          getTabImage('images/v83_gift.png'),
          getTabImage('images/v83_gift.png')
        ],
        [
          getTabImage('images/v82_sunlight.png'),
          getTabImage('images/v82_sunlight.png')
        ],
        [getTabImage('images/v81_moon.png'), getTabImage('images/v81_moon.png')]
      ];
    }
    _body = new IndexedStack(
      children: <Widget>[
        new WXArticleComponent(
          message: "a",
        ),
        new ClassifyComponent(
          message: "iOS",
        ),
        new WelfareComponent(
          message: "福利",
        ),
        new WelfareDoubleListComponent(
          message: "d",
        )
      ],
      index: _tabIndex,
    );
  }
}
