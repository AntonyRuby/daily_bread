import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'bible.dart';
import 'dailyMassReadings.dart';
import 'saintOfTheDay.dart';
import 'search.dart';

Widget portrait(context, now, snapshot) {
  var data = json.decode(snapshot.data["verses"].toString());
  var daily = json.decode(snapshot.data["daily"].toString());
  var saints = json.decode(snapshot.data["saints"].toString());
  var saintName = daily[new DateFormat("yyyy-MM-dd").format(now)]["saint"];
  var saintOfTheDay = saints[saintName];
  var bible = json.decode(snapshot.data["bible"].toString());

  return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: Text(
            new DateFormat("EEEE, dd MMMM yyyy").format(now),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                alignment: Alignment.centerRight,
                splashColor: Colors.blueAccent,
                icon: Icon(
                  Icons.share,
                  color: Colors.blueAccent,
                ),
                onPressed: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(
                      data[new DateFormat("yyyy-MM-dd").format(now)]["verse"],
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                }),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                body: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 0),
                                        child: Center(
                                          child: SelectableText(
                                            data[new DateFormat("yyyy-MM-dd")
                                                .format(now)]["verse"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(
                    data[new DateFormat("yyyy-MM-dd").format(now)]["verse"],
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.justify,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
        Container(height: 20),
        Container(
          height: 48,
          child: InkWell(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Image(
                          image: AssetImage('asset/images/saintoftheday.PNG'),
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Center(
                        child: Text(saintName,
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ),
                  ]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Saint(saint: {
                              "name": saintOfTheDay["name"],
                              "period": saintOfTheDay["period"],
                              "img": "asset/images/" + saintOfTheDay["img"],
                              "about": saintOfTheDay["about"]
                            })));
              }),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Container(
            color: Colors.blue[700],
            height: 65,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image:
                                  AssetImage('asset/images/Mass Readings.png'),
                              width: MediaQuery.of(context).size.width / 21),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              "Mass Readings",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MassReadings(
                                    dailyreadings: daily[
                                        new DateFormat("yyyy-MM-dd")
                                            .format(now)]["readings"],
                                  )));
                    },
                  ),
                  InkWell(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image:
                                AssetImage('asset/images/Saint Dictionary.png'),
                            width: MediaQuery.of(context).size.width / 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              "Saints Dictionary",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(saintlist: saints)));
                    },
                  ),
                  InkWell(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('asset/images/Holybible.png'),
                            width: MediaQuery.of(context).size.width / 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              "Holy Bible",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookScreen(bible: bible)));
                    },
                  )
                ]),
          ),
        ),
      ]);
}
