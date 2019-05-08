import 'dart:math';
import 'dart:ui';

import 'package:tetris/bean/square.dart';
import 'package:tetris/bean/square_z.dart';
import 'package:tetris/bean/square_o.dart';
import 'package:tetris/bean/square_t.dart';
import 'package:tetris/bean/square_i.dart';
import 'package:tetris/bean/square_l.dart';
import 'package:tetris/bean/square_l_reverse.dart';
import 'package:tetris/bean/square_z_reverse.dart';

class SquareFactory {
  final _random = new Random();

  Square create(Rect backgroundRect) {
    int _type = _random.nextInt(7);
    int _rotate = _random.nextInt(4);
    int _startX = (backgroundRect.left + backgroundRect.width / 2).floor();
    int _startY = backgroundRect.top.floor();

    switch (_type) {
      case 0:
        return new SquareI(_startX, _startY, _rotate);
      case 1:
        return new SquareL(_startX, _startY, _rotate);
      case 2:
        return new SquareLReverse(_startX, _startY, _rotate);
      case 3:
        return new SquareO(_startX, _startY, _rotate);
      case 4:
        return new SquareT(_startX, _startY, _rotate);
      case 5:
        return new SquareZ(_startX, _startY, _rotate);
      case 6:
        return new SquareZReverse(_startX, _startY, _rotate);
      default:
        return new SquareI(_startX, _startY, _rotate);
    }
  }
}
