import 'dart:convert';
import 'dart:ui';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:verses/bible.dart';
import 'saintOfTheDay.dart';
import 'search.dart';
import 'dailyMassReadings.dart';
import 'package:splashscreen/splashscreen.dart';
import 'bible.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Verses for the day",
    theme: ThemeData(
      primaryColor: Colors.blue[500],
      appBarTheme: AppBarTheme(color: Colors.blue[700]),
      navigationRailTheme:
          NavigationRailThemeData(backgroundColor: Colors.blue[200]),
      accentColor: Colors.blue,
      textTheme: TextTheme(
        headline5: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        headline6: TextStyle(
          color: Colors.white,
        ),
        headline4: TextStyle(
          color: Colors.black,
        ),
        bodyText1: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
        bodyText2: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
        subtitle1: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        subtitle2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        button: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      title:
          new Text('Daily Bread', style: Theme.of(context).textTheme.headline5),
      image: Image.asset('asset/images/Capture.PNG'),
      photoSize: 100,
      styleTextUnderTheLoader: new TextStyle(),
      navigateAfterSeconds: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var now = new DateTime.now();
  DateTime _currentdate = new DateTime.now();

  previousDay() {
    setState(() {
      now = new DateTime(now.year, now.month, now.day - 1);
    });
  }

  nextDay() {
    setState(() {
      now = new DateTime(now.year, now.month, now.day + 1);
    });
  }

  Future<Map<String, String>> loadAssets() async {
    final verses =
        await DefaultAssetBundle.of(context).loadString('asset/verses.json');
    final saints =
        await DefaultAssetBundle.of(context).loadString('asset/saints.json');
    final daily =
        await DefaultAssetBundle.of(context).loadString('asset/daily.json');
    final bible =
        await DefaultAssetBundle.of(context).loadString('asset/bible.json');

    return {'verses': verses, 'saints': saints, 'daily': daily, 'bible': bible};
  }

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2022),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });

    if (_seldate != null) {
      setState(() {
        now = _seldate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Thought for the day',
          style: Theme.of(context).textTheme.headline6,
        )),
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _selectdate(context);
              }),
          IconButton(
              icon: Icon(Icons.arrow_back_ios), onPressed: () => previousDay()),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios), onPressed: () => nextDay()),
        ],
        elevation: 0,
      ),
      body: FutureBuilder(
          future: loadAssets(),
          builder: (context, snapshot) {
            var data = json.decode(snapshot.data["verses"].toString());
            var daily = json.decode(snapshot.data["daily"].toString());
            var saints = json.decode(snapshot.data["saints"].toString());
            var saintName =
                daily[new DateFormat("yyyy-MM-dd").format(now)]["saint"];
            var saintOfTheDay = saints[saintName];
            var bible = json.decode(snapshot.data["bible"].toString());

            if (data == null) {
              return Center(
                child: Text("Loading"),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                        child: Text(
                          new DateFormat("EEEE, dd MMMM yyyy").format(now),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 08, 16, 0),
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
                                final RenderBox box =
                                    context.findRenderObject();
                                Share.share(
                                    data[new DateFormat("yyyy-MM-dd")
                                        .format(now)]["verse"],
                                    sharePositionOrigin:
                                        box.localToGlobal(Offset.zero) &
                                            box.size);
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Text(
                          data[new DateFormat("yyyy-MM-dd").format(now)]
                              ["verse"],
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.justify,
                          // maxLines: 20,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: InkWell(
                          // splashColor: Colors.blueAccent,
                          // highlightColor: Colors.blue[100],
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage(
                                          'asset/images/MassReadings.jpg'),
                                      width:
                                          MediaQuery.of(context).size.width / 9,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Center(
                                    child: Text(
                                      "Mass Readings",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                )
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
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: InkWell(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            'asset/images/Saint.png'),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Center(
                                      child: Text(saintName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
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
                                            "img": "asset/images/" +
                                                saintOfTheDay["img"],
                                            "about": saintOfTheDay["about"]
                                          })));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Container(
                          color: Colors.blue[700],
                          height: 85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'asset/images/Saint Dic.jpg'),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Text(
                                          "Saints Dictionary",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
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
                                        image: AssetImage(
                                            'asset/images/bible.jpg'),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Text(
                                          "Holy Bible",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                    ]),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookScreen(bible: bible)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              );
            }
          }),
    );
  }
}
