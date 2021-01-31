import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendarData.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  List _selectedEvents = [];

  @override
  void initState() {
    _calendarController = CalendarController();
    setupEvents();
    super.initState();
  }

  setupEvents() async {
    await CalendarData.getEvents();
    setState(() {});
  }

  _onDaySelected(DateTime day, List events, _) {
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          SizedBox(
            width: 250,
            child: Column(
              children: [
                Container(height: 25),
                Text("Work", style: TextStyle(fontSize: 32)),
                Expanded(
                  child: ListView(
                    children: _selectedEvents.map((e) => ListTile(title: Text(e))).toList(),
                  ),
                ),
                Row(
                  children: [
                    Text((_calendarController.focusedDay ?? DateTime.now()).month.toString())
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: TableCalendar(
              events: CalendarData.events,
              calendarController: _calendarController,
              onDaySelected: _onDaySelected,
              locale: 'en_US',
              headerVisible: false,
              builders: CalendarBuilders(
                markersBuilder: (context, date, events, _) {
                  final children = <Widget>[];
                  if(events.isNotEmpty) {
                    children.add(
                      Positioned(
                        right: 1,
                        bottom: 1,
                        child: Icon(Icons.circle),
                      )
                    );
                  }
                  return children;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}