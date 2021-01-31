import 'userdata.dart';
import 'subject.dart';
import 'package:intl/intl.dart';

class CalendarData {
  static Map<DateTime, List> events = {};
  
  static getEvents() {
    UserData.subjects.forEach((Subject s) {
      s.events.forEach((e) {
        DateTime _date = DateTime.parse(DateFormat('yyyy-MM-dd').format(e.date));
        String _title = e.title;
        if(!e.isTest)
        _title += " - " + e.compTime.toString() + "min";
        if (events.containsKey(_date)) {
          events[_date].add(_title);
        } else {
          events[_date] = [_title];
        }
      });
    });
  }
}