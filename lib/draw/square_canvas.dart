import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui show TextStyle;

import 'package:flutter/material.dart';
import 'package:tetris/bean/square.dart';
import 'package:tetris/bean/square_container.dart';
import 'package:tetris/bean/square_rect.dart';
import 'package:tetris/constant/constant.dart';
import 'package:tetris/square_factory.dart';

class SquareCanvasPainter extends CustomPainter {
  final SquareContainer _container;
  final Square _square;
  final int _count;

  //倒计时的数字设置的颜色
  final List<Color> _colors = [
    Colors.purple,
    Colors.blue,
    Colors.amberAccent,
    Colors.pink,
    Colors.deepOrange
  ];

  SquareCanvasPainter(this._container, this._square, this._count);

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = new Paint()..strokeCap = StrokeCap.square;
    //******************************绘制倒计时逻辑*******************************
    if (_count > 0) {
      ParagraphBuilder builder =
          new ParagraphBuilder(new ParagraphStyle(fontSize: 180));
      ParagraphConstraints pc = ParagraphConstraints(width: size.width);
      builder.pushStyle(ui.TextStyle(
          //background: new Paint()..color = Colors.red,
          color: _colors[_count % 5],
          fontWeight: FontWeight.w900));
      builder.addText(_count.toString());
      Paragraph paragraph = builder.build()..layout(pc);
      /*canvas.drawParagraph(paragraph,
          Offset(paragraph.width / 3, (size.height - paragraph.height) / 2));*/
      canvas.drawParagraph(
          paragraph,
          Offset(
              (size.width - paragraph.minIntrinsicWidth) / 2, size.height / 3));
    }
    //******************************绘制倒计时逻辑*******************************

    //******************************绘制倒计时逻辑*********************************
    if (_square != null) {
      _container.draw(canvas, _paint);

      _paint.color = Colors.black;

      //绘制正在操作的图形
      List<SquareRect> _curRect = _square.get();

      for (int i = 0; i < _curRect.length; i++) {
        _curRect[i].draw(canvas, _paint);
      }
    }
    //******************************绘制游戏逻辑*********************************
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
  Timer _gameTimer;
  Timer _countdownTimer;

  SquareContainer _container;
  Square _square;

  TapDownDetails _details;

  //倒计时游戏开始
  int count = 5;

  //图形的下落间隔时间
  int _dur = 300;

  @override
  void initState() {
    super.initState();
    _container = new SquareContainer();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new CustomPaint(
        painter: new SquareCanvasPainter(_container, _square, count),
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

  //点击边界左侧，左移
  //点击边界右侧，右移
  //点击容器，旋转
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
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
  }

  //开始倒计时
  void _startCountdown() {
    _countdownTimer = new Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        count--;
        if (count == 0) {
          _countdownTimer.cancel();
          _startPlay();
        }
      });
    });
  }

  void _startPlay() {
    _square = new SquareFactory().create(_container.background);
    _gameTimer = new Timer.periodic(Duration(milliseconds: _dur), (timer) {
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
}
