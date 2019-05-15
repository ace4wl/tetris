class Score {
  num score = 0;

  //消除一行得到的分数
  num _rowScore = 100;

  void cul(num rows) {
    for (int i = 0; i < rows; i++) {
      score += (i + 1) * _rowScore;
    }
  }
}
