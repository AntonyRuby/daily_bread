import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'bible.dart';
import 'dailyMassReadings.dart';
import 'saintOfTheDay.dart';
import 'search.dart';

Widget landscape(context, now, snapshot) {
  var data = json.decode(snapshot.data["verses"].toString());
  var daily = json.decode(snapshot.data["daily"].toString());
  var saints = json.decode(snapshot.data["saints"].toString());
  var saintName = daily[new DateFormat("yyyy-MM-dd").format(now)]["saint"];
  var saintOfTheDay = saints[saintName];
  var bible = json.decode(snapshot.data["bible"].toString());

  return Row(children: [
    Expanded(
        flex: 5,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
                    child: Text(
                      new DateFormat("EEEE, dd MMMM yyyy").format(now),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 16, 4),
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
                                data[new DateFormat("yyyy-MM-dd").format(now)]
                                    ["verse"],
                                sharePositionOrigin:
                                    box.localToGlobal(Offset.zero) & box.size);
                          }),
                    ),
                  ),
                ]),
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
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
          Container(
            height: 48,
            color: Colors.grey[300],
            child: InkWell(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Image(
                            image: AssetImage('asset/images/saintoftheday.PNG'),
                            height: MediaQuery.of(context).size.height / 10,
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
        ])),
    Expanded(
        flex: 1,
        child: Container(
            color: Colors.blue[700],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image:
                                  AssetImage('asset/images/Mass Readings.png'),
                              width: MediaQuery.of(context).size.width / 25),
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
                            width: MediaQuery.of(context).size.width / 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              "Saints Dictionary",
                              style: Theme.of(context).textTheme.button,
                              textAlign: TextAlign.center,
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
                            width: MediaQuery.of(context).size.width / 20,
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
                ])))
  ]);
}
