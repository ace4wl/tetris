// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:tetris/constant/area.dart';
import 'package:tetris/constant/constant.dart';
import 'package:tetris/draw/square_canvas.dart';

class GamePlayWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _divide(context);
    return MaterialApp(
        title: 'Flutter Code Sample for material.AppBar.actions',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: new Scaffold(
            body: new Container(
          padding: EdgeInsets.only(top: 60.0),
          child: new SquareCanvasWidget(),
          color: Colors.white,
        )));
  }

  void _divide(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _culTopArea(size.width, size.height);
    _culMiddleArea(size.width, size.height);
    _culBottomArea(size.width, size.height);
  }

  void _culTopArea(double width, double height) {
    Area.topRect = Rect.fromLTWH(0, 0, width, height / 20);
  }

  void _culMiddleArea(double width, double height) {
    Area.middleRect = Rect.fromLTWH(0, height / 20, width, height *14 / 20);

    int unit = (Area.middleRect.height / Constant.ROWS).floor();
    if (unit * Constant.COLUMNS > Area.middleRect.width) {
      unit = (Area.middleRect.width / Constant.COLUMNS).floor();
    }
    Constant.SQUARE_WIDTH = Constant.SQUARE_HEIGHT = unit;

    double padding = (width - Constant.SQUARE_WIDTH * Constant.COLUMNS) / 2;

    Area.boardRect = Rect.fromLTWH(
        padding,
        Area.middleRect.top.floor().toDouble(),
        Constant.SQUARE_WIDTH.toDouble() * Constant.COLUMNS,
        Constant.SQUARE_HEIGHT.toDouble() * Constant.ROWS);

    print(Area.boardRect.toString());
  }

  void _culBottomArea(double width, double height) {
    Area.bottomRect = Rect.fromLTWH(0, height * 15 / 20, width, height * 5 / 20);
  }
}
