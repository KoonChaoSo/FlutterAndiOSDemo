import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/contants/RounterContants.dart';
import 'package:flutter_base/pages/PhotoPickPages.dart';
import 'package:flutter_base/pages/TestPages.dart';
import 'package:flutter_base/pages/WXArticleListPages.dart';
import 'package:flutter_base/pages/WebPages.dart';
import 'package:flutter_base/widgets/PhotoView.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new WebPage("ojhero", "https://github.com/ojhero");
});

var demoRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String,List<String>> params) {
  return new PhotoPickComponent();
});

var webHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params[Routes.webTitle]?.first;
  String url = params[Routes.webUrl]?.first;
  if (title == null) {
    title = "";
  }
  if (url == null) {
    url = "";
  }
  return new WebPage(title, url);
});

var photoHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String url = params[Routes.webUrl]?.first;
  if (url == null) {
    url = "";
  }
  return new GridPhotoViewer(url);
});

var wxArticleListHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params[Routes.wxArticleId]?.first;
  if (id == null) {
    id = "";
  }
  return new WXArticleListComponent(id);
});

// var demoRouteHandler = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   String message = params["message"]?.first;
//   String colorHex = params["color_hex"]?.first;
//   String result = params["result"]?.first;
//   Color color = new Color(0xFFFFFFFF);
//   // if (colorHex != null && colorHex.length > 0) {
//   //   color = new Color(ColorHelpers.fromHexString(colorHex));
//   // }
//   return new DemoSimpleComponent(
//       message: message, color: color, result: result);
// });

var demoFunctionHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String message = params["message"]?.first;
      showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(
              "Hey Hey!",
              style: new TextStyle(
                color: const Color(0xFF00D6F7),
                fontFamily: "Lazer84",
                fontSize: 22.0,
              ),
            ),
            content: new Text("$message"),
            actions: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
                child: new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: new Text("OK"),
                ),
              ),
            ],
          );
        },
      );
    });

// var deepLinkHandler = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   String colorHex = params["color_hex"]?.first;
//   String result = params["result"]?.first;
//   Color color = new Color(0xFFFFFFFF);
//   // if (colorHex != null && colorHex.length > 0) {
//   //   color = new Color(ColorHelpers.fromHexString(colorHex));
//   // }
//   return new DemoSimpleComponent(
//       message: "DEEEEEP LINK!!!", color: color, result: result);
// });
