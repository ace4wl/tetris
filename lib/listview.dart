// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWordsWidget> {
  @override
  Widget build(BuildContext context) {
    return _listView();
  }

  Widget _listView() {
    final _words = <WordPair>[];

    return new ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return new Divider();
          }

          final num = index ~/ 2;

          if (num >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }

          return new ListTile(
            title: Text(_words[num].asPascalCase),
          );
        });
  }
}
