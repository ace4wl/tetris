import 'dart:ui';

import 'package:flutter/material.dart';

class SquareRect {
  int _left;

  int _top;

  int _right;

  int _bottom;

  int _width;

  int _height;

  SquareRect(this._left, this._top, this._width, this._height) {
    _right = _left + _width;
    _bottom = _top + _height;
  }

  SquareRect.orign(Rect rect) {
    _left = rect.left.floor();
    _top = rect.top.floor();
    _right = rect.right.floor();
    _bottom = rect.bottom.floor();
    _width = rect.width.floor();
    _height = rect.height.floor();
  }

  void draw(Canvas canvas, Paint paint) {
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(convert(), paint);
  }

  Rect convert() {
    Rect rect = Rect.fromLTWH(_left.toDouble(), _top.toDouble(),
        _width.toDouble(), _height.toDouble());
    return rect;
  }

  void tranlateY(int offset) {
    top += offset;
    bottom += offset;
  }

  int get height => _height;

  set height(int value) {
    _height = value;
  }

  int get width => _width;

  set width(int value) {
    _width = value;
  }

  int get bottom => _bottom;

  set bottom(int value) {
    _bottom = value;
  }

  int get right => _right;

  set right(int value) {
    _right = value;
  }

  int get top => _top;

  set top(int value) {
    _top = value;
  }

  int get left => _left;

  set left(int value) {
    _left = value;
  }

  @override
  String toString() {
    return "[" +
        left.toString() +
        "," +
        top.toString() +
        "," +
        right.toString() +
        "," +
        bottom.toString() +
        "]";
  }
}
