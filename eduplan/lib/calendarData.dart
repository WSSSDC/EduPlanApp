import 'userdata.dart';
import 'subject.dart';
import 'package:intl/intl.dart';

class CalendarData {
  static Map<DateTime, List> events = {};
  static Map<DateTime, List> holidays = {};
  
  static DateTime stripTime(DateTime before){
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(before));
  }

  static getEvents() {
    events = {};
    UserData.subjects.forEach((Subject s) {
      s.events.forEach((e) {
        DateTime _date = stripTime(e.date);
        String _title = e.title;
        if(!e.isTest)
        _title += " - " + e.compTime.toString() + " min";
        if (events.containsKey(_date)) {
          events[_date].add(_title);
        } else {
          events[_date] = [_title];
        }
      });
    });
  }

  static getHolidays() {
    holidays = {};
    UserData.subjects.forEach((Subject s) {
      s.subsubjects.forEach((element) {
        element.events.forEach((e) {
          DateTime _date = stripTime(e.date);
          String _title = e.title + " - " + element.courseCode;
          if(!e.isTest)
          _title += " - " + e.compTime.toString() + " min";
          if (holidays.containsKey(_date)) {
            holidays[_date].add(_title);
          } else {
            holidays[_date] = [_title];
          }
        });
      });
    });
  }
}