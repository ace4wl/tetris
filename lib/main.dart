// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:tetris/constant/constant.dart';
import 'package:tetris/draw/square_canvas.dart';
import 'package:tetris/game_launch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.AppBar.actions',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constant.CANVAS_WIDTH = size.width.floor();
    Constant.CANVAS_HEIGHT = size.height.floor();

    return Scaffold(
      appBar: AppBar(
        title: Text('俄罗斯方块'),
      ),
      body: new GameLaunch(),
    );
  }
}
