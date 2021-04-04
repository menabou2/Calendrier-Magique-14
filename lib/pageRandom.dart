import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class pageRandom extends StatefulWidget {
  var _events = {};
  var _selectedEvents = [];
  var _controller = CalendarController();
  pageRandom();
  @override
  _pageRandomState createState() => _pageRandomState();
}

class _pageRandomState extends State<pageRandom> {
  var _events = {};
  var txt;
  var _selectedEvents = [];
  var _controller = CalendarController();
  _pageRandomState();

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, 2),
          colors: [const Color(0xFF04273D), const Color(0xFF0E86D4)],
          //colors: [ const Color(0xFF0E86D4), const Color(0xFF04273D)],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sur ma route"),
        ),
        backgroundColor: Colors.transparent,
        body: Center(

          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ),


      ),

    );
  }
}
