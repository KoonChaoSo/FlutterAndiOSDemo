import 'package:flutter/material.dart';

class TestComponent extends StatelessWidget {
  TestComponent(
      {String message = "Testing",
      Color color = const Color(0xFFFFFFFF),
      String result})
      : this.message = message,
        this.color = color,
        this.result = result;

  final String message;
  final Color color;
  final String result;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("Test", style: new TextStyle(color: Colors.white)),
//        iconTheme: new IconThemeData(color: Colors.white),
//      ),
      body: new Material(
        color: color,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Image(
              image: new AssetImage("./images/v84_money.png"),
              color: Colors.red,
              width: 260.0,
            ),
            new Padding(
              padding: new EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
              child: new Text(
                message,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.black,
                  height: 2.0,
                ),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 15.0),
              child: new ConstrainedBox(
                constraints: new BoxConstraints(minHeight: 42.0),
                child: new FlatButton(
                  highlightColor: Colors.yellow,
                  splashColor: Colors.black,
                  onPressed: () {
                    if (result == null) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context, result);
                    }
                  },
                  child: new Text(
                    "OK",
                    style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
