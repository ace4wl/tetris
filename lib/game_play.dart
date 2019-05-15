// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:tetris/draw/square_canvas.dart';

class GamePlayWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Code Sample for material.AppBar.actions',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: new Scaffold(
            appBar: AppBar(
              title: Text(''),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: new Container(
              child: new SquareCanvasWidget(),
              color: Colors.white,
            )));
  }
}
