import 'student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  String id = "";
  String title = "";
  List<String> studentRefs = [];
  List<Student> students = [];

  Subject.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.studentRefs = data.data()['students'];

    //TODO: Conv list of student refs (Strings) to student objects
  }
}

