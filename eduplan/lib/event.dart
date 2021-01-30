import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id = "";
  String title = "";
  String desc = "";
  DateTime date = DateTime.now();
  bool isTest = false;

  Event.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.desc = data.data()['desc'];
    this.isTest = data.data()['isTest'];

    //TODO: Convert timestamp to datetime
  }
}