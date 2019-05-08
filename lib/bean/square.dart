import 'dart:ui';

import 'package:tetris/bean/square_rect.dart';
import 'package:tetris/constant/constant.dart';

abstract class Square {
  int w = Constant.SQUARE_WIDTH;
  int h = Constant.SQUARE_HEIGHT;

  int x;
  int y = 0;

  int width;

  int height;

  int speed = 5;

  //0=原始位置 1=顺时针旋转90° 2=顺时针旋转180° 3=顺时针旋转270°
  int rotateDir;

  Square(this.x, this.y, this.rotateDir);

  List<SquareRect> get() {
    switch (rotateDir) {
      case 1:
        return rotate90();
      case 2:
        return rotate180();
      case 3:
        return rotate270();
      default:
        return rotate0();
    }
  }

  List<SquareRect> rotate0();

  List<SquareRect> rotate90();

  List<SquareRect> rotate180();

  List<SquareRect> rotate270();
}
