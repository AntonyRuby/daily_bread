import 'dart:async';
import 'package:flutter/material.dart';
import 'saintOfTheDay.dart';
import 'package:flutter/foundation.dart';

class SearchPage extends StatefulWidget {
  final saintlist;
  SearchPage({Key key, @required this.saintlist}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class Saintname {
  String image;
  String name;
  String about;
  String period;

  Saintname(String image, String name, String about, String period) {
    this.image = image;
    this.name = name;
    this.about = about;
    this.period = period;
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _SearchPageState extends State<SearchPage> {
  final _debouncer = Debouncer(milliseconds: 300);
  List<Saintname> saintnames = new List();
  List<Saintname> filteredsaintnames = new List();
  String _searchText = "";
  TextEditingController _searchController;

  @override
  void initState() {
    {
      widget.saintlist.forEach((key, value) => {
            saintnames.add(new Saintname(
              "asset/images/" + value["img"],
              key,
              value["about"],
              value["period"],
            ))
          });

      setState(() {
        filteredsaintnames = saintnames;
      });

      _searchController = TextEditingController();
      _searchController.addListener(() {
        setState(() {
          _searchText = _searchController.text;
        });
      });

      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Saints of the Year")),
        body: Container(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    filteredsaintnames = saintnames
                        .where((p) => (p.name
                            .toLowerCase()
                            .contains(string.toLowerCase())))
                        .toList();
                  });
                });
              },
              controller: _searchController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  suffixIcon: _searchText.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              filteredsaintnames = saintnames;
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: filteredsaintnames.isEmpty
                ? Center(
                    child: Text(
                      "No results found",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredsaintnames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Saint(saint: {
                                        "img": filteredsaintnames[index].image,
                                        "about":
                                            filteredsaintnames[index].about,
                                        "name": filteredsaintnames[index].name,
                                        "period":
                                            filteredsaintnames[index].period,
                                      })));
                        },
                        child: Card(
                          elevation: 0,
                          child: Row(
                            children: <Widget>[
                              Image.asset(filteredsaintnames[index].image,
                                  height: 60, width: 60),
                              SizedBox(width: 20),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.35,
                                  child: Text(filteredsaintnames[index].name)),
                            ],
                          ),
                        ),
                      );
                    }),
          )
        ])));
  }
}
