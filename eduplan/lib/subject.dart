import 'package:cloud_firestore/cloud_firestore.dart';
import 'event.dart';
import 'student.dart';
import 'userdata.dart';

class Subject {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  String id = "";
  String title = "";
  String courseCode = "";
  List<String> studentRefs = [];
  List<Student> students = [];
  List<String> subsubjectRefs = [];
  List<SubSubject> subsubjects = [];
  List<Event> events = [];

  Subject.create(id, title, courseCode){
    this.id = id;
    this.title = title;
    this.courseCode = courseCode;
  }

  Subject.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.courseCode = data.data()['courseCode'];
    this.studentRefs = List<String>.from(data.data()['students'] ?? []);
    this.subsubjectRefs = List<String>.from(data.data()['subjects'] ?? []);
    
    if(!UserData.isStudent)
    _getSubSubjects();
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

  Future<void> setSubject() {
    return _instance.collection("subjects").doc(id).set({
      'title': title,
      'courseCode': courseCode,
      'students': studentRefs
    });
  }

  Future<void> _getSubSubjects() async {
    subsubjects = await Future.wait(subsubjectRefs.map((e) async => await _getSubSubject(e)));
  }

  Future<SubSubject> _getSubSubject(String docid) async {
    return _instance.collection("subjects").doc(docid).get().then((data){ 
        return SubSubject.data(data);
      }
    );
  }
}

class SubSubject{
  String id;
  String title = "";
  String courseCode = "";
  List<Event> events = [];
  static FirebaseFirestore _instance = FirebaseFirestore.instance;

  SubSubject.data(DocumentSnapshot data){
    this.id = data.id;
    this.title = data.data()['title'];
    this.courseCode = data.data()['courseCode'];
    _getEvents(data);
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
