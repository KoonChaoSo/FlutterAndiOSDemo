import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_base/base/BaseApplication.dart';
import 'package:flutter_base/contants/RounterContants.dart';
import 'package:flutter_base/utils/BottomBarUtils.dart';
import 'package:flutter_base/widgets/LeftDrawer.dart';

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return new AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    BottomBarUtils.initData();
    final app = new MaterialApp(
      title: 'Fluro',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
              title:
                  new Text("base", style: new TextStyle(color: Colors.white)),
              iconTheme: new IconThemeData(color: Colors.white)),
          body: BottomBarUtils.getBody(),
          bottomNavigationBar: new CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                  icon: BottomBarUtils.getTabIcon(0), title: BottomBarUtils.getTabTitle(0)),
              new BottomNavigationBarItem(
                  icon: BottomBarUtils.getTabIcon(1), title: BottomBarUtils.getTabTitle(1)),
              new BottomNavigationBarItem(
                  icon: BottomBarUtils.getTabIcon(2), title: BottomBarUtils.getTabTitle(2)),
              new BottomNavigationBarItem(
                  icon: BottomBarUtils.getTabIcon(3), title: BottomBarUtils.getTabTitle(3)),
            ],
            currentIndex: BottomBarUtils.getTabIndex(),
            onTap: (index) {
              setState(() {
                BottomBarUtils.setTabIndex(index);
              });
            },
          ),
          drawer: new BaseDrawer()),
      onGenerateRoute: Application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
