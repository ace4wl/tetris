import 'package:tetris/bean/square_rect.dart';

import 'square.dart';

class SquareT extends Square {
  SquareT(x, y, rotateDir) : super(x, y, rotateDir);

  @override
  List<SquareRect> rotate0() {
    List<SquareRect> points = <SquareRect>[];
    points.add(new SquareRect(x, y, w, h));
    points.add(new SquareRect(x + w, y, w, h));
    points.add(new SquareRect(x + w, y + h, w, h));
    points.add(new SquareRect(x + w + w, y, w, h));

    width = 3 * w;
    height = 2 * h;

    return points;
  }

  @override
  List<SquareRect> rotate90() {
    List<SquareRect> points = <SquareRect>[];
    points.add(new SquareRect(x + w, y, w, h));
    points.add(new SquareRect(x, y + h, w, h));
    points.add(new SquareRect(x + w, y + h, w, h));
    points.add(new SquareRect(x + w, y + h + h, w, h));

    width = 2 * w;
    height = 3 * h;

    return points;
  }

  @override
  List<SquareRect> rotate180() {
    List<SquareRect> points = <SquareRect>[];
    points.add(new SquareRect(x, y + h, w, h));
    points.add(new SquareRect(x + w, y, w, h));
    points.add(new SquareRect(x + w, y + h, w, h));
    points.add(new SquareRect(x + w + w, y + h, w, h));

    width = 3 * w;
    height = 2 * h;

    return points;
  }

  @override
  List<SquareRect> rotate270() {
    List<SquareRect> points = <SquareRect>[];
    points.add(new SquareRect(x, y, w, h));
    points.add(new SquareRect(x, y + h, w, h));
    points.add(new SquareRect(x + w, y + h, w, h));
    points.add(new SquareRect(x, y + h + h, w, h));

    width = 2 * w;
    height = 3 * h;

    return points;
  }
}
