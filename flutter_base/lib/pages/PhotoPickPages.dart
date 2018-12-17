import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickComponent extends StatefulWidget {
  PhotoPickComponent(
      {String message = "Photo Pick",
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

class _NewsListState extends State<PhotoPickComponent> {
  File _image;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }

  Future showPickDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("选择Dialog"),
              content: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new InkWell(
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    child: new Text("拍照", style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),),
                  ),
                  new InkWell(
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: new Text("选择图片", style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                      height: 2,
                    ),),
                  ),
                ],
              ),
            actions:<Widget>[
              new FlatButton(child:new Text("CANCEL"), onPressed: (){
                Navigator.of(context).pop();

              },),
              new FlatButton(child:new Text("OK"), onPressed: (){
                Navigator.of(context).pop();

              },)
            ]
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker Example'),
      ),
      body: new Center(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showPickDialog(context);
        },
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
