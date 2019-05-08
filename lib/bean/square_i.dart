import 'package:tetris/bean/square_rect.dart';

import 'square.dart';

class SquareI extends Square {
  SquareI(x, y, rotateDir) : super(x, y, rotateDir);

  @override
  List<SquareRect> rotate0() {
    List<SquareRect> points = <SquareRect>[];

    points.add(new SquareRect(x, y, w, h));
    points.add(new SquareRect(x, y + h, w, h));
    points.add(new SquareRect(x, y + h + h, w, h));
    points.add(new SquareRect(x, y + h + h + h, w, h));

    width = w;
    height = 4 * h;

    return points;
  }

  @override
  List<SquareRect> rotate90() {
    List<SquareRect> points = <SquareRect>[];

    points.add(new SquareRect(x, y, w, h));
    points.add(new SquareRect(x + w, y, w, h));
    points.add(new SquareRect(x + w + w, y, w, h));
    points.add(new SquareRect(x + w + w + w, y, w, h));

    width = 4 * w;
    height = h;

    return points;
  }

  @override
  List<SquareRect> rotate180() {
    return rotate0();
  }

  @override
  List<SquareRect> rotate270() {
    return rotate90();
  }
}
