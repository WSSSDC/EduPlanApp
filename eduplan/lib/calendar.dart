import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendarData.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  List _selectedEvents = [];
  String _currentMonth = DateFormat("MMMM").format(DateTime.now());

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
                Row(
                  children: [
                    MaterialButton(
                      child: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text("Work", style: TextStyle(fontSize: 32)),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: _selectedEvents.map((e) => ListTile(title: Text(e))).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(_currentMonth, style: TextStyle(fontSize: 32))
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: TableCalendar(
              events: CalendarData.events,
              calendarController: _calendarController,
              onDaySelected: _onDaySelected,
              onVisibleDaysChanged: (DateTime first, DateTime last, _) {
                setState(() => _currentMonth = DateFormat("MMMM").format(first.add(Duration(days: 7))));
              }, 
              locale: 'en_US',
              headerVisible: false,
              builders: CalendarBuilders(
                markersBuilder: (context, date, events, _) {
                  final children = <Widget>[];
                  if(events.isNotEmpty) {
                    children.add(
                      Positioned(
                        right: 1,
                        bottom: 130,
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