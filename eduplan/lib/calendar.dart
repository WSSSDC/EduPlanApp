import 'package:eduplan/userdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendarData.dart';
import 'package:intl/intl.dart';
import 'event.dart';

List _selectedEvents = [];
List _selectedHolidays = [];

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>{
  CalendarController _calendarController;
  String _currentMonth = DateFormat("MMMM").format(DateTime.now());
  Event _event = new Event.create("", "", false, 0, DateTime.now());

  @override
  void initState() {
    _calendarController = CalendarController();
    setupEvents();
    setupHolidays();
    super.initState();
  }

  setupEvents() async {
    await CalendarData.getEvents();
    _selectedEvents = CalendarData.events[CalendarData.stripTime(DateTime.now())] ?? [];
    setState(() {});
  }

  setupHolidays() async {
    await CalendarData.getHolidays();
    _selectedHolidays = CalendarData.holidays[CalendarData.stripTime(DateTime.now())] ?? [];
    setState(() {});
  }

  _onDaySelected(DateTime day, List events, List holidays) {
    _event.date = day;
    setState((){
      _selectedEvents = events;
      _selectedHolidays = holidays;
    });
  }

  void update() {

  }

  void _createEvent(context) {
    showDialog(
      context: context,
      builder: (context) {
        return CreateEventAlert(_event);
      }
    ).then((value){
      setState(() {
        _selectedEvents.add(value.title);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          SizedBox(
            width: 350,
            child: Container(
              //color: Colors.black54,
              child: Column(
                children: [
                  Container(height: 40),
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
                      children: 
                      List<Widget>.from(_selectedEvents.map((e) => 
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.blue, size: 20),
                        title: Text(e),
                        trailing: (UserData.isStudent) ? null : MaterialButton(
                          child: Icon(Icons.delete),
                          onPressed: () async {
                            setState(() {
                              _selectedEvents.remove(e);
                              CalendarData.events[CalendarData.stripTime(DateTime.now())].remove(e);
                            });
                          },
                        ),
                      )
                      ).toList())
                      + (UserData.isStudent ? [] : <Widget>[
                        MaterialButton(
                          child: Icon(Icons.add),
                          onPressed: () => _createEvent(context),
                        )
                      ] +
                      List<Widget>.from(_selectedHolidays.map((e) => 
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.red, size: 20),
                        title: Text(e))
                      ).toList())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(_currentMonth, style: TextStyle(fontSize: 32, color: Colors.black45))
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 3,
            child: Expanded(
              child: Container(
                color: Colors.black26
              )
            ),
          ),
          Expanded(
            child: TableCalendar(
              events: CalendarData.events,
              holidays: CalendarData.holidays,
              calendarController: _calendarController,
              onDaySelected: _onDaySelected,
              onVisibleDaysChanged: (DateTime first, DateTime last, _) {
                setState(() => _currentMonth = DateFormat("MMMM").format(first.add(Duration(days: 7))));
              }, 
              locale: 'en_US',
              headerVisible: false,
              calendarStyle: CalendarStyle(
                holidayStyle: TextStyle(
                  color: Colors.black
                ),
                weekdayStyle: TextStyle(
                  color: Colors.black
                ),
                todayColor: Colors.transparent,
                selectedColor: Colors.black87,
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                ),
                outsideDaysVisible: false,
                contentDecoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.black26)
                  )
                )
              ),
              builders: CalendarBuilders(
                markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];
                  if(events.isNotEmpty) {
                    for(int i = 0; i < events.length + holidays.length; i++) {
                      children.add(
                        Positioned(
                          right: i * 20.0,
                          bottom: 10,
                          child: Icon(Icons.circle, color: (i < holidays.length ? Colors.red : Colors.blue), size: 20),
                        )
                      );
                    }
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

class CreateEventAlert extends StatefulWidget {
  CreateEventAlert(this._event);
  final Event _event;

  @override
  _CreateEventAlertState createState() => _CreateEventAlertState(_event);
}

class _CreateEventAlertState extends State<CreateEventAlert> {
  _CreateEventAlertState(this._event);
  final Event _event;
  String _eventSubject = UserData.subjects[0].title ?? "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 320,
        child: Column(
          children: [
            Text("Create an Event"),
            Container(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Event Name'
              ),
              onChanged: (v) => _event.title = v,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description'
              ),
              onChanged: (v) => _event.desc = v,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Completion Time (mins)'
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _event.compTime = int.parse(v) ?? 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Is this a test? "),
                Checkbox(
                  value: _event.isTest,
                  onChanged: (v) => setState(() => _event.isTest = v),
                )
              ],
            ),
            DropdownButton(
              value: _eventSubject,
              onChanged: (v) => setState(() => _eventSubject = v),
              items: UserData.subjects.map<DropdownMenuItem<String>>((e){
                return DropdownMenuItem<String>(
                  child: Text(e.title),
                  value: e.title
                );
              }).toList(),
            )
          ],
        ),
      ),
      actions: [
        MaterialButton(
          child: Text("Cancel", style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          child: Text("Add", style: TextStyle(color: Colors.blue)),
          onPressed: () async {
            await _event.setEvent(UserData.subjects.where((e) => e.title == _eventSubject).toList()[0].id);
            await UserData.getData();
            CalendarData.getEvents();
            Navigator.pop(context, _event);
          },
        )
      ],
    );
  }
}


/*
class HomeworkTile extends StatefulWidget {
  HomeworkTile(this.e, this.notify, this.isHoliday);
  final String e;
  final Function notify;
  final bool isHoliday;

  @override
  _HomeworkTileState createState() => _HomeworkTileState(e, notify, isHoliday);
}

class _HomeworkTileState extends State<HomeworkTile> {
  _HomeworkTileState(this.e, this.notify, this.isHoliday);
  final String e;
  final Function notify;
  final bool isHoliday;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(e),
      trailing: (UserData.isStudent || this.isHoliday) ? null : MaterialButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          /*UserData.subjects.forEach((s) {
            if(s.events.where((eve) => (eve.title + " - " + s.courseCode) == e).isNotEmpty)
            s.events.where((eve) => (eve.title + " - " + s.courseCode) == e).first.deleteEvent(s.id);
          });*/
          setState(() {
            _selectedEvents.remove(e);
            CalendarData.events[CalendarData.stripTime(DateTime.now())].remove(e);
          });
          this.widget.notify();
        },
      ),
    );
  }
}*/