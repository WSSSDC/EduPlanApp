import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id = "";
  String title = "";
  String desc = "";
  int compTime = 0;
  bool isTest = false;
  DateTime date = DateTime.now();

  Event.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.desc = data.data()['desc'];
    this.isTest = data.data()['isTest'];
    this.compTime = data.data()['compTime'];
    Timestamp date = data.data()['date'];
    this.date = DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
  }
}
