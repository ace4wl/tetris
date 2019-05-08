import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/bean/square.dart';
import 'package:tetris/bean/square_container.dart';
import 'package:tetris/bean/square_rect.dart';
import 'package:tetris/constant/constant.dart';
import 'package:tetris/square_factory.dart';

class SquareCanvasPainter extends CustomPainter {
  final SquareContainer _container;
  final Square _square;

  SquareCanvasPainter(this._container, this._square);

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = new Paint()
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1.0;

    _container.draw(canvas, _paint);

    _paint.color = Colors.black;

    //绘制正在操作的图形
    List<SquareRect> _curRect = _square.get();

    for (int i = 0; i < _curRect.length; i++) {
      _curRect[i].draw(canvas, _paint);
    }
  }

  @override
  bool shouldRepaint(SquareCanvasPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class SquareCanvasWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SquareCanvasState();
  }
}

class SquareCanvasState extends State<SquareCanvasWidget> {
  Timer _timer;

  SquareContainer _container;
  Square _square;

  TapDownDetails _details;

  int _dur = 300;

  @override
  void initState() {
    super.initState();
    _container = new SquareContainer();
    _square = new SquareFactory().create(_container.background);
    _timer = new Timer.periodic(Duration(milliseconds: _dur), (timer) {
      setState(() {
        if (_container.checkDownMove(_square)) {
          _square.y += Constant.SQUARE_HEIGHT;
        } else {
          if (_container.gameOver()) {
            _container.reset();
          }
          _square = new SquareFactory().create(_container.background);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new CustomPaint(
        painter: new SquareCanvasPainter(_container, _square),
        /***************************************************************************
         * ***************************************************************************
         * ***************************************************************************
         * FUCK!!!!!，查了许多的demo，都没有写这句话 2019/4/28 v1.0.0
         * ***************************************************************************
         * ***************************************************************************
         * ***************************************************************************
         */
        size: Size(Constant.CANVAS_WIDTH.toDouble(),
            Constant.CANVAS_HEIGHT.toDouble()),
      ),
      onTapDown: (TapDownDetails details) {
        _details = details;
      },
      onTap: () {
        _onClick();
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (details.delta.dy > 1) {
          _dur = 1;
        }
      },
    );
  }

  void _onClick() {
    if (_details == null) return;

    if (_details.globalPosition.dx < _container.background.left) {
      //点击边框左侧的区域，左移
      setState(() {
        if (_container.checkLeftMove(_square)) {
          _square.x -= Constant.SQUARE_WIDTH;
        }
      });
    } else if (_details.globalPosition.dx > _container.background.right) {
      //点击边框右侧的区域，右移
      setState(() {
        if (_container.checkRightMove(_square)) {
          _square.x += Constant.SQUARE_WIDTH;
        }
      });
    } else {
      //点击边框区域内，旋转
      setState(() {
        _square.rotateDir = (_square.rotateDir + 1) % 4;
        _container.checkDownMove(_square);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
