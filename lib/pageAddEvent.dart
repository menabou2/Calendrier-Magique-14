import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class pageAddEvent extends StatefulWidget {
  var _events = {};
  var _selectedEvents = [];
  var _controller = CalendarController();
  pageAddEvent();
  @override
  _pageAddEventState createState() => _pageAddEventState();
}

class _pageAddEventState extends State<pageAddEvent> {
  var _events = {};
  var txt;
  var _selectedEvents = [];
  var _controller = CalendarController();
  _pageAddEventState();

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
          title: Text("Ajouter une tâche"),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.0, 2),
                colors: [const Color(0xFFCF000F), const Color(0xFF450005)],
                //colors: [ const Color(0xFF0E86D4), const Color(0xFF04273D)],
              ),
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ),
        ),
      ),
    );
  }
}
