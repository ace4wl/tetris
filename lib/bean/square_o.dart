import 'package:tetris/bean/square_rect.dart';

import 'square.dart';

class SquareO extends Square {
  SquareO(x, y, rotateDir) : super(x, y, rotateDir);

  @override
  List<SquareRect> rotate0() {
    List<SquareRect> points = <SquareRect>[];
    points.add(new SquareRect(x, y, w, h));
    points.add(new SquareRect(x + w, y, w, h));
    points.add(new SquareRect(x, y + h, w, h));
    points.add(new SquareRect(x + h, y + h, w, h));

    width = 2 * w;
    height = 2 * h;

    return points;
  }

  @override
  List<SquareRect> rotate180() {
    return rotate0();
  }

  @override
  List<SquareRect> rotate270() {
    return rotate0();
  }

  @override
  List<SquareRect> rotate90() {
    return rotate0();
  }
}
