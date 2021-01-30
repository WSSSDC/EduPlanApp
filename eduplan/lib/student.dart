import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String id = "";
  String first = "";
  String last = "";
  String email = "";

  Student.data(DocumentSnapshot data) {
    this.id = data.id;
    this.first = data.data()['name']['first'];
    this.last = data.data()['name']['last'];
    this.email = data.data()['email'];
  }
}