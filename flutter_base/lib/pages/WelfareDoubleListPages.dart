import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/api/Api.dart';
import 'package:flutter_base/base/BaseApplication.dart';
import 'package:flutter_base/contants/RounterContants.dart';
import 'package:flutter_base/utils/NetUtils.dart';
import 'package:flutter_base/utils/Utf8Utils.dart';

// 福利妹子多列列表
class WelfareDoubleListComponent extends StatefulWidget {
  WelfareDoubleListComponent(
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

class _NewsListState extends State<WelfareDoubleListComponent> {
  int _page = 1;
  static final int _pageSize = 20;
  List listData = new List();
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget _buildItem(String url) {
      return new GestureDetector(
        child: new CachedNetworkImage(
          placeholder: CupertinoActivityIndicator(),
          imageUrl: url,
          fit: BoxFit.cover,
        ),
        onTap: () {
          Application.router.navigateTo(
              context,
              Routes.photoLink +
                  "?" +
                  Routes.webUrl +
                  "=" +
                  Utf8Utils.lineToASC(url));
        },
      );
    }

    List<Widget> _getItemList() {
      List<Widget> widgets = List();
      for (int i = 0; i < listData.length; i++) {
        widgets.add(_buildItem(listData[i]['url']));
      }
      return widgets;
    }

    return new RefreshIndicator(
      child: GridView.count(
        crossAxisCount: 2, // 几列显示
        padding: EdgeInsets.all(8.0),
        mainAxisSpacing: 8.0,
        //主轴方向间距 （竖直方向）
        crossAxisSpacing: 8.0,
        //横向间距
        primary: false,
        children: _getItemList(),
        controller: _controller,
      ),
      onRefresh: _pullToRefresh,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      //最大可滑动距离
      var maxScroll = _controller.position.maxScrollExtent;
      //当前距离
      var pixels = _controller.position.pixels;
      //滑动到底部
      if (maxScroll == pixels) {
        _page++;
        loadingData();
      }
    });
    loadingData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadingData() {
    NetUtils.get(Api.GANK_WELFARE + '$_pageSize/$_page', (data) {
      if (data != null) {
        setState(() {
          if (_page == 1) {
            listData.clear();
          }
          listData.addAll(data);
        });
      }
    });
  }

  Future<Null> _pullToRefresh() async {
    print("刷新成功");
    _page = 1;
    loadingData();
    return null;
  }
}
