import 'package:flutter/material.dart';
import 'package:daily_bread/main_landscape.dart';
import 'package:daily_bread/main_portrait.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Daily Bread",
    theme: ThemeData(
      primaryColor: Colors.blue[500],
      appBarTheme: AppBarTheme(color: Colors.blue[700]),
      navigationRailTheme:
          NavigationRailThemeData(backgroundColor: Colors.blue[200]),
      hintColor: Colors.blue,
      textTheme: TextTheme(
        headlineSmall:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
        bodyMedium: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
        titleMedium: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        titleSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    home: MainScreen(),
  ));
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
    final DateTime? _seldate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2024, 12, 31),
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
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Thought for the day',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectdate(context);
                }),
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => previousDay()),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () => nextDay()),
          ],
          elevation: 0,
        ),
        body: FutureBuilder(
            future: loadAssets(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text("Loading"),
                );
              }

              Orientation orientation = MediaQuery.of(context).orientation;
              if (orientation == Orientation.portrait) {
                return portrait(context, now, snapshot);
              } else {
                return landscape(context, now, snapshot);
              }
            }),
      ),
    );
  }
}
