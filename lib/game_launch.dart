import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tetris/game_play.dart';

class GameLaunch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
              flex: 1,
              child: new Container(
                child: new Text(
                  "俄罗斯方块",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Colors.blueAccent),
                ),
                alignment: Alignment.center,
              )),
          new Expanded(
            flex: 4,
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 15),
                  child: _createTextButton('开始游戏', () {
                    _startGame(context);
                  }),
                ),
                new Container(
                    margin: EdgeInsets.only(top: 30),
                    child: _createTextButton('操作说明', () {
                      _startGame(context);
                    })),
              ],
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Text(
              "Lyn",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  //创建按钮
  Widget _createTextButton(String text, Function func) {
    return new RaisedButton(
        child: new Text(
          text,
          style: new TextStyle(fontSize: 20),
        ),
        textColor: Colors.purple,
        color: Colors.white,
        highlightColor: Colors.amberAccent,
        padding: new EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        elevation: 0,
        animationDuration: const Duration(milliseconds: 5000),
        shape: new Border.all(color: Colors.purple, width: 1),
        onPressed: func);
  }

  Widget _createText(String text) {
    return new Container(
      child: new Text(
        text,
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
            fontSize: 20),
      ),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(5)),
          border: new Border.all(color: Colors.purple, width: 1)),
      padding: new EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    );
  }

  void _startGame(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new GamePlayWidget()));
  }
}
