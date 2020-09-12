import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BookScreen extends StatelessWidget {
  final bible;
  BookScreen({Key key, @required this.bible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List> books = new List();
    bible.forEach((key, value) => {
          books.add([key, value])
        });

    return Scaffold(
        appBar: AppBar(title: Text("The Holy Bible")),
        body: Container(
          child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chapters(
                                book: books[index][1], name: books[index][0])));
                  },
                  child: Card(
                    elevation: 0,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(books[index][0])),
                  ),
                );
              }),
        ));
  }
}

class Chapters extends StatelessWidget {
  final book;
  final name;
  Chapters({Key key, @required this.book, @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List> chapters = new List();
    for (var i = 0; i < book.length; i++) {
      chapters.add(["Chapter " + (i + 1).toString(), book[i]]);
    }

    return Scaffold(
        appBar: AppBar(title: Text(name)),
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
                                book: chapters[index][1],
                                name: name + " : " + chapters[index][0],
                                next: (index + 1) < chapters.length
                                    ? {
                                        book: chapters[index + 1][1],
                                        name: chapters[index + 1][0]
                                      }
                                    : {name: "none"})));
                  },
                  child: Card(
                    elevation: 0,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(chapters[index][0])),
                  ),
                );
              }),
        ));
  }
}

class Verses extends StatelessWidget {
  final book;
  final name;
  final next;
  Verses(
      {Key key, @required this.book, @required this.name, @required this.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> verses = new List();
    book.forEach((verse) => verses.add(verse));
    if (next["name"] != "none") {
      book.add("Next Chapter");
    }

    return Scaffold(
        appBar: AppBar(title: Text(name)),
        body: Container(
          child: ListView.builder(
              itemCount: verses.length,
              itemBuilder: (BuildContext context, int index) {
                if (verses[index] == "Next Chapter") {
                  return InkWell(
                    child: Card(
                        elevation: 0,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Next Chapter",
                              textAlign: TextAlign.right,
                            ))),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chapters(
                                  book: next["book"], name: next["name"])));
                    },
                  );
                } else {
                  return Card(
                      elevation: 0,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              leading: SelectableText((index + 1).toString()),
                              title: SelectableText(
                                verses[index],
                                toolbarOptions: ToolbarOptions(
                                    copy: true, paste: true, selectAll: true),
                                style: Theme.of(context).textTheme.bodyText1,
                              ))));
                }
              }),
        ));
  }
}
