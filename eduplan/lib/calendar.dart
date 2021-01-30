import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendarData.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;

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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          TableCalendar(
              events: CalendarData.events,
              calendarController: _calendarController,
              locale: 'en_US',
            ),
        ],
      ),
    );
  }
}