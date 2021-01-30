import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id = "";
  String title = "";
  String desc = "";
  Timestamp date;
  int compTime = 0;
  bool isTest = false;
  DateTime trueDate = DateTime.now();

  Event.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.desc = data.data()['desc'];
    this.isTest = data.data()['isTest'];
    this.date = data.data()['date'];
    this.compTime = data.data()['compTime'];
    trueDate = DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
    //TODO: Convert timestamp to datetime
  }
}
