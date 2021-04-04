import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import './tabMonthCalendar.dart';
import './tabPrincipal.dart';
import './tabSettings.dart';
import './pageAddEvent.dart';
import './dayView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // WIDGET BUILD---
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendrier Bouks',
      //theme: ThemeData(
      // primarySwatch: Colors.pink,
      // ),
      home: HomePage(),
    );
  }
}

class AfterSplashPage extends StatefulWidget {
  AfterSplash createState() => AfterSplash();
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new AfterSplashPage(),
        title: new Text(
          'Bienvenue :)\nChargement en cours...',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        image: new Image.asset('assets/images/dogecoin.png'),
        //backgroundColor: Colors.white,

        gradientBackground: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.0, 2),
          colors: [const Color(0xFF0E86D4), const Color(0xFF800028)],
        ),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 50.0,
        loaderColor: Colors.indigo[500]);
  }
}

class AfterSplash extends State<AfterSplashPage> with TickerProviderStateMixin {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  AnimationController _animationController;
  SharedPreferences prefs;
  var eventsDetailled;
  static var tabIndex;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    tabIndex = 0;
    initPrefs();
    eventsDetailled = [
      FlutterWeekViewEvent(
        title: 'Changer les pneus de la Tesla',
        description: 'changement saisonnier',
        start: DateTime.parse("2021-04-04 20:18:00Z"),
        end: DateTime.parse("2021-04-04 22:00:00Z"),
      ),
      FlutterWeekViewEvent(
        title: 'Regarder Jojo<s bizarre adventure',
        description: 'A description 2',
        start: DateTime.parse("2021-04-04 21:30:00Z"),
        end: DateTime.parse("2021-04-04 23:30:00Z"),
        backgroundColor: Colors.green[800],
      )
    ];

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  void _handleTabIndex() {
    setState(() {});
  }

  // Méthode Init stockage de données via SharedPref
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  // Encodage Map
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    newMap.removeWhere((key, value) => key == null || value == null);
    return newMap;
  }

  // Décodage map
  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    newMap.removeWhere((key, value) => key == null || value == null);
    return newMap;
  }

  // WIDGET BUILD ----------
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF04273D),
        accentColor: Color(0xFF04273D),
      ),
      home: DefaultTabController(
        length: 3,
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                indicatorColor: Color(0xFF0E86D4),
                tabs: [
                  // Tab #1
                  Tab(icon: Icon(Icons.home)),

                  // Tab #2
                  Tab(icon: Icon(Icons.calendar_today)),

                  // Tab #3
                  Tab(icon: Icon(Icons.settings)),
                ],
              ),
              title: Text('Calendrier Bouks'),
            ),
            body: TabBarView(
              children: [
                // Tab #1
                tabPrincipal(
                    _events, _selectedEvents, _controller, eventsDetailled),

                // Tab #2
                tabMonthCalendar(_events, _selectedEvents, _controller),

                // Tab #3
                tabSettings(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                tabIndex = DefaultTabController.of(context).index;
                _showAddDialog();
                print(tabIndex);
              },
            ),
          );
        }),
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context, false);
                  });
                },
                child: Text("Annuler")),
            FlatButton(
              child: Text("Sauvegarder"),
              onPressed: () {
                if (tabIndex == 0) {
                  print(tabIndex);
                } else if (tabIndex == 1) {
                  if (_eventController.text.isEmpty) {
                    print('0');
                    print(_controller.selectedDay);
                    return;
                  }
                  setState(() {
                    if (_events[_controller.selectedDay] != null) {
                      print('1');
                      _events[_controller.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_controller.selectedDay] = [
                        _eventController.text
                      ];
                      print('2');
                    }
                    prefs.setString(
                        "events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context, true);
                  });
                } else if (tabIndex == 2) {
                  print(tabIndex);
                }
              },
            )
          ],
        ));
    //if (tabIndex == 1) {
    //  setState(() {
    //    _selectedEvents = _events[_controller.selectedDay];
    //  });
    //}
  }
}
