import 'package:cloud_firestore/cloud_firestore.dart';
import 'event.dart';
import 'student.dart';

class Subject {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  String id = "";
  String title = "";
  String courseCode = "";
  List<String> studentRefs = [];
  List<Student> students = [];
  List<Event> events = [];

  Subject.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.courseCode = data.data()['courseCode'];
    this.studentRefs = List<String>.from(data.data()['students']);
    _getStudents();
    _getEvents(data);
  }

  _getStudents() async {
    this.students =
        await Future.wait(studentRefs.map((e) async => await _getStudent(e)));
  }

  Future<Student> _getStudent(String docid) async {
    return _instance
        .collection("users")
        .doc(docid)
        .get()
        .then((data) => Student.data(data));
  }

  Future<void> _getEvents(DocumentSnapshot data) {
    return _instance.collection("subjects").doc(id).collection('events')
    .get()
    .then((QuerySnapshot data) {
      data.docs.forEach((e) {
        this.events.add(Event.data(e));
      });
    });
  }
}
