import 'package:cloud_firestore/cloud_firestore.dart';
import 'student.dart';

class Subject {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  String id = "";
  String title = "";
  List<String> studentRefs = [];
  List<Student> students = [];

  Subject.data(DocumentSnapshot data) {
    this.id = data.id;
    this.title = data.data()['title'];
    this.studentRefs = data.data()['students'];
    _getStudents();
    //TODO: Conv list of student refs (Strings) to student objects
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
}
