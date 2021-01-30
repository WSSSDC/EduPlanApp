import 'userdata.dart';
import 'subject.dart';

class CalendarData {
  static Map<DateTime, List> events = {};

  static getEvents() {
    UserData.subjects.forEach((Subject s) {
      s.events.forEach((e) {
        if (events.containsKey(e.date)) {
          events[e.date].add(e.title);
        } else {
          events[e.date] = [e.title];
        }
      });
    });
    print(CalendarData.events);
  }
}