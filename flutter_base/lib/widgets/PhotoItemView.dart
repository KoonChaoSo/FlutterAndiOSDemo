import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/base/BaseApplication.dart';
import 'package:flutter_base/contants/RounterContants.dart';
import 'package:flutter_base/utils/Utf8Utils.dart';

// ignore: non_constant_identifier_names
Widget BuildWelfareRows(context, String url, String desc) {
  final ThemeData theme = Theme.of(context);
  final TextStyle titleStyle =
      theme.textTheme.headline.copyWith(color: Colors.white);

  return new InkWell(
      onTap: () => Application.router.navigateTo(
          context, Routes.photoLink + "?" + Routes.webUrl + "=" + Utf8Utils.lineToASC(url)),
      child: new Card(
        margin: new EdgeInsets.all(2.0),
        child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new SizedBox(
              height: 300.0,
              child: new Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: new CachedNetworkImage(
                      placeholder: CupertinoActivityIndicator(),
                      imageUrl: url,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    bottom: 6.0,
                    left: 6.0,
                    right: 6.0,
                    child: new FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomLeft,
//                      child: new Text(
//                        desc,
//                        style: titleStyle,
//                      ),
                    ),
                  ),
                ],
              ),
            )),
      ));
}
