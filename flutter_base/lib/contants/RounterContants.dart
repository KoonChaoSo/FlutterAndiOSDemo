import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './RounterHandlers.dart';

class Routes {
  static String webTitle = "web_title";
  static String webUrl = "web_url";
  static String wxArticleId = "wx_id";

  static String root = "/ojhero";
  static String demoSimple = "/demo";
  static String demoFunc = "/func";
  static String deepLink = "/message";
  static String webLink = "/web";
  static String photoLink = "/photo";
  static String wxArticleListLink = "/article";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(demoSimple, handler: demoRouteHandler);
    router.define(demoFunc, handler: demoFunctionHandler);
    router.define(webLink, handler: webHandler);
    router.define(photoLink, handler: photoHandler);
    router.define(wxArticleListLink, handler: wxArticleListHandler);
  }
}
