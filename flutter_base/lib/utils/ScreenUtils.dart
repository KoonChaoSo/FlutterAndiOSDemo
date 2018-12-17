import 'package:flutter/material.dart';

class ScreenUtils {
  /**
   * 屏幕宽度
   */
  double getScreenWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }

  /**
   * 屏幕高度
   */
  double getScreenHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .height;
  }

  /**
   * 状态栏高度
   */
  double getStatusHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .padding
        .top;
  }

  /**
   * 屏幕方向
   */
  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery
        .of(context)
        .orientation;
  }

  /**
   * AppBar的默认高度,系统默认的常量定义于constants类中
   */
  double getAppBarHeight(BuildContext context) {
    return kToolbarHeight;
  }
}