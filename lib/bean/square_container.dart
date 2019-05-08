import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tetris/bean/square.dart';
import 'package:tetris/bean/square_rect.dart';
import 'package:tetris/constant/constant.dart';

class SquareContainer {
  Rect background;

  //行数作为y，矩形列表作为值，表示每一行的矩形列表
  Map _group = new Map();

  Path _subLinePath = new Path();

  SquareContainer() {
    //计算当前宽高下的单位宽高
    int width =
        Constant.CANVAS_WIDTH - Constant.PADDING_LEFT - Constant.PADDING_RIGHT;
    int height =
        Constant.CANVAS_HEIGHT - Constant.PADDING_BOTTOM - Constant.PADDING_TOP;

    if (width / Constant.COLUMNS > height / Constant.ROWS) {
      Constant.SQUARE_HEIGHT =
          Constant.SQUARE_WIDTH = (height / Constant.ROWS).floor();
    } else {
      Constant.SQUARE_HEIGHT =
          Constant.SQUARE_WIDTH = (width / Constant.COLUMNS).floor();
    }

    int realWidth = Constant.SQUARE_WIDTH * Constant.COLUMNS;
    int realHeight = Constant.SQUARE_HEIGHT * Constant.ROWS;

    //背景
    background = new Rect.fromLTWH(
        ((Constant.CANVAS_WIDTH - realWidth) / 2).toDouble(),
        (Constant.CANVAS_HEIGHT - Constant.PADDING_BOTTOM - realHeight)
            .toDouble(),
        realWidth.toDouble(),
        realHeight.toDouble());

    //辅助线
    for (int i = 0; i < Constant.ROWS; i++) {
      _subLinePath.moveTo(
          background.left, background.top + i * Constant.SQUARE_HEIGHT);
      _subLinePath.lineTo(
          background.right, background.top + i * Constant.SQUARE_HEIGHT);
    }

    for (int i = 0; i < Constant.COLUMNS; i++) {
      _subLinePath.moveTo(
          background.left + i * Constant.SQUARE_WIDTH, background.bottom);
      _subLinePath.lineTo(
          background.left + i * Constant.SQUARE_WIDTH, background.top);
    }
  }

  // 以行数为key,行数对应的单元rect列表为值分组
  void _groupSquareRect(Square square) {
    List<SquareRect> _curRectList = square.get();

    for (SquareRect rect in _curRectList) {
      if (_group[rect.top] == null) _group[rect.top] = <SquareRect>[];
      List<SquareRect> rectList = _group[rect.top];
      rectList.add(rect);
    }
  }

  //检测图形是否越界或者变为背景的一部分，返回true表示可以下落
  bool checkDownMove(Square square) {
    List<SquareRect> _squareRectList = square.get();

    for (SquareRect squareRect in _squareRectList) {
      //到达底部边界，下落图形变为背景的一部分，并消除铺满行
      if (squareRect.bottom == background.bottom) {
        _groupSquareRect(square);
        _removeRows();
        return false;
      }

      for (int row in _group.keys) {
        List<SquareRect> _rowRectList = _group[row];
        for (SquareRect rowRect in _rowRectList) {
          //到底其他图形的顶部，下落图形变为背景的一部分，并消除铺满行
          if (rowRect.top == squareRect.bottom &&
              rowRect.left == squareRect.left &&
              rowRect.right == squareRect.right) {
            _groupSquareRect(square);
            _removeRows();
            return false;
          }
        }
      }
    }

    return true;
  }

  //左移检测，返回true表示可以左移
  bool checkLeftMove(Square square) {
    List<SquareRect> _squareRectList = square.get();

    if (square.x.floor() <= background.left) {
      return false;
    }

    //检测左侧是否有阻碍块
    for (SquareRect rect in _squareRectList) {
      List<SquareRect> rowRect = _group[rect.top];
      if (rowRect == null) continue;
      for (SquareRect squareRect in rowRect) {
        if (squareRect.top == rect.top &&
            squareRect.bottom == rect.bottom &&
            squareRect.right == rect.left) {
          return false;
        }
      }
    }

    return true;
  }

  bool checkRightMove(Square square) {
    List<SquareRect> _squareRectList = square.get();

    if (square.x + square.width >= background.right) {
      return false;
    }

    //检测左侧是否有阻碍块
    for (SquareRect rect in _squareRectList) {
      List<SquareRect> rowRect = _group[rect.top];
      if (rowRect == null) continue;
      for (SquareRect squareRect in rowRect) {
        if (squareRect.top == rect.top &&
            squareRect.bottom == rect.bottom &&
            squareRect.left == rect.right) {
          return false;
        }
      }
    }

    return true;
  }

  //绘制
  void draw(Canvas canvas, Paint paint) {
    paint.style = PaintingStyle.stroke;
    //绘制网格
    paint..color = Colors.black12;
    canvas.drawPath(_subLinePath, paint);
    //绘制边框
    paint..color = Colors.blueAccent;
    canvas.drawRect(background, paint);
    //绘制阻碍块
    for (int row in _group.keys) {
      List<SquareRect> rowRectList = _group[row];
      for (SquareRect rect in rowRectList) {
        Rect drawRect = rect.convert();
        paint.color = Colors.blue;
        paint.style = PaintingStyle.fill;
        canvas.drawRect(drawRect, paint);

        paint.style = PaintingStyle.stroke;
        paint.color = Colors.black;
        canvas.drawRect(drawRect, paint);
      }
    }
  }

  Rect convert(SquareRect squareRect) {
    return Rect.fromLTWH(squareRect.left.toDouble(), squareRect.top.toDouble(),
        squareRect.width.toDouble(), squareRect.height.toDouble());
  }

  bool gameOver() {
    return _group[background.top] != null;
  }

  void _removeRows() {
    //被消除的行
    List<int> removeRows = <int>[];

    //遍历每一行
    for (int row in _group.keys) {
      List<SquareRect> rowRectList = _group[row];
      //若该行的矩形框数等于列数，表示铺满，消除该行
      if (rowRectList.length == Constant.COLUMNS) {
        print(_group.toString());
        //记录被删除的行
        removeRows.add(row);
        //记录需要被删除的块
        List<SquareRect> needRemove = <SquareRect>[];
        for (SquareRect rect in rowRectList) needRemove.add(rect);
        //从背景中删除
        for (SquareRect rect in needRemove) rowRectList.remove(rect);
      }
    }

    //被删除的行,从小到大排序
    removeRows.sort((int a, int b) {
      return a > b ? 1 : 0;
    });

    //遍历删除的行，大于被删除的行的Rect高度减小一个单位
    List<SquareRect> translateRect = <SquareRect>[];
    for (int r in removeRows) {
      var beyondRows =
          _group.keys.where((item) => (item < r && !removeRows.contains(item)));

      for (int sr in beyondRows) {
        List<SquareRect> beyondRectList = _group[sr];
        translateRect.addAll(beyondRectList);
      }
    }

    //改变分组
    for (SquareRect r in translateRect) {
      List<SquareRect> from = _group[r.top];
      from.remove(r);
      r.tranlateY(Constant.SQUARE_HEIGHT);
      from = _group[r.top];
      from.add(r);
    }
  }

  void reset() {
    _group.clear();
  }
}
