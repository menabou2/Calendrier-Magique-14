import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class dayView extends StatefulWidget {
  var _eventsMap = {};
  var eventsDetailled = [];

  dayView(this._eventsMap, this.eventsDetailled);

// var _events = _eventsMap.entries.map((e) => (e.key, e.value)).toList();
//  _eventsMap.forEach((k, v) => _events.add(_events(k, v)));
// print(_events);

  @override
  _dayViewState createState() => _dayViewState(this._eventsMap, this.eventsDetailled);
}

class _dayViewState extends State<dayView> {
  DayViewController _controller = DayViewController();
  var _eventsMap = {};
  var eventsDetailled = [];



  _dayViewState(this._eventsMap, this.eventsDetailled);

  @override
  Widget build(BuildContext context) {
    // Let's get two dates :
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    var departevent1 = (eventsDetailled[0].end).isAtSameMomentAs(eventsDetailled[1].start);
    if(departevent1 == false){
      print(departevent1);
    }
    print(departevent1);

    HourMinute _heureActuelle = HourMinute.now();
    _heureActuelle = _heureActuelle.subtract(HourMinute(hour: 1, minute: 0));


// And here's our widget !
    return Container(
      child: DayView(
        controller: _controller,
        date: now,
        userZoomable: true,

        minimumTime: _heureActuelle,
        inScrollableWidget: true,
        hoursColumnStyle: HoursColumnStyle(
          interval: Duration(minutes: 30),
            textStyle: TextStyle(color: Colors.white, fontSize: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFFCF000F), const Color(0xFF0E86D4)],
                //colors: [ const Color(0xFF0E86D4), const Color(0xFF04273D)],
              ),
            )
        ),

        dayBarStyle: DayBarStyle(
            color: Color(0xFFCF000F),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [const Color(0xFFCF000F), const Color(0xFF450005)],
                //colors: [ const Color(0xFF0E86D4), const Color(0xFF04273D)],
              ),
            )
        ),

        events: eventsDetailled,

        style: DayViewStyle.fromDate(
          date: now,
          currentTimeCircleRadius: 8,
          hourRowHeight: 50,
          headerSize: 25,
          backgroundRulesColor: Color(0xFF04273D),
          currentTimeRuleColor: Color(0xFF04273D),
          currentTimeRuleHeight: 3,
          currentTimeCircleColor: Color(0xFF04273D),
        ),
      ),
    );
  }
}
