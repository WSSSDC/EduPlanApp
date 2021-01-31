import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id = "";
  String title = "";
  String desc = "";
  int compTime = 0;
  bool isTest = false;
  DateTime date = DateTime.now();

  Event.create(String title, String desc, bool isTest, int compTime, DateTime date) {
    this.title = title;
    this.desc = desc;
    this.isTest = isTest;
    this.compTime = compTime;
    this.date = date;
  }

  Event.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.desc = data.data()['desc'];
    this.isTest = data.data()['isTest'];
    this.compTime = data.data()['compTime'];
    Timestamp date = data.data()['date'];
    this.date = DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
  }

  setEvent(String subId) {
    FirebaseFirestore _auth = FirebaseFirestore.instance;
    _auth.collection("subjects").doc(subId).collection("events").doc().set({
      'title': title,
      'desc': desc,
      'compTime': compTime,
      'isTest': isTest,
      'date': date
    }, SetOptions(merge: true));
  }

  deleteEvent(String subId) {
    FirebaseFirestore _auth = FirebaseFirestore.instance;
    _auth.collection("subjects").doc(subId).collection("events").doc(id).delete();
  }
}
