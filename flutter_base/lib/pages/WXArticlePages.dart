import 'package:flutter/material.dart';
import 'package:flutter_base/api/Api.dart';
import 'package:flutter_base/base/BaseApplication.dart';
import 'package:flutter_base/contants/RounterContants.dart';
import 'package:flutter_base/utils/NetUtils.dart';

// 微信公众号作者列表
class WXArticleComponent extends StatefulWidget {
  WXArticleComponent(
      {String message = "Testing",
      Color color = const Color(0xFFFFFFFF),
      String result})
      : this.message = message,
        this.color = color,
        this.result = result;

  final String message;
  final Color color;
  final String result;

  _NewsListState createState() => new _NewsListState();
}

class _NewsListState extends State<WXArticleComponent> {
  List listData = new List();

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(2.0),
        itemCount: listData == null ? 0 : listData.length,
        itemBuilder: (context, i) {
          return new InkWell(
              onTap: () {
                int id = listData[i]['id'];
                Application.router
                    .navigateTo(context, Routes.wxArticleListLink + "?" + Routes.wxArticleId + "=$id");
              },
              child: new Card(
                child: new ListTile(
                  title: new Text(listData[i]['name']),
                ),
              ));
        },
      ),
      onRefresh: _pullToRefresh,
    );
  }

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  void loadingData() {
    NetUtils.get(Api.WAN_WXARTICLE, (data) {
      if (data != null) {
        setState(() {
          listData.clear();
          listData.addAll(data);
        });
      }
    });
  }

  Future<Null> _pullToRefresh() async {
    print("刷新成功");
    loadingData();
    return null;
  }
}
