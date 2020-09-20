import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BookScreen extends StatelessWidget {
  final bible;
  BookScreen({Key key, @required this.bible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("The Holy Bible")),
        body: Container(
          child: ListView.builder(
              itemCount: bible.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chapters(
                                bible: bible,
                                book: bible.keys.toList()[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.all(5),
                      child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            bible.keys.toList()[index],
                            style: Theme.of(context).textTheme.subtitle1,
                          )),
                    ),
                  ),
                );
              }),
        ));
  }
}

class Chapters extends StatelessWidget {
  final book;
  final bible;
  Chapters({Key key, @required this.bible, @required this.book})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List> chapters = new List();
    for (var i = 0; i < bible[book].length; i++) {
      chapters.add(["Chapter " + (i + 1).toString(), i]);
    }

    return Scaffold(
        appBar: AppBar(title: Text(book)),
        body: Container(
          child: ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Verses(
                                bible: bible, book: book, chapter: index)));
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(chapters[index][0]))),
                      )),
                );
              }),
        ));
  }
}

class Verses extends StatelessWidget {
  final bible;
  final book;
  final chapter;
  Verses(
      {Key key,
      @required this.bible,
      @required this.book,
      @required this.chapter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<String>> verses = new List();
    for (var i = 0; i < bible[book][chapter].length; i++) {
      verses.add(["Verse " + (i + 1).toString(), i.toString()]);
    }

    if (chapter < bible[book].length - 1) {
      verses.add(["Next Chapter", ""]);
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(book + " : Chapter " + (chapter + 1).toString())),
        body: Container(
          child: ListView.builder(
              itemCount: verses.length,
              itemBuilder: (BuildContext context, int index) {
                if (verses[index][0] == "Next Chapter") {
                  return InkWell(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Card(
                            elevation: 0,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 4, 16, 4),
                                    child: Text(
                                      "Next Chapter",
                                      textAlign: TextAlign.right,
                                    ))))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Verses(
                                  bible: bible,
                                  book: book,
                                  chapter: chapter + 1)));
                    },
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Card(
                          elevation: 0,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  leading: Text((index + 1).toString()),
                                  subtitle: Text(bible[book][chapter]
                                      [int.parse(verses[index][1])])))));
                }
              }),
        ));
  }
}
