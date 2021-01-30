import 'package:cloud_firestore/cloud_firestore.dart';
import 'subject.dart';

class UserData {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  static String id = "5OQbxtjwz8nn3KLMpFRG";
  static String first = "";
  static String last = "";
  static String email = "";
  static List<String> subjectRefs = [];
  static List<Subject> subjects = [];

  static Future<void> getData() {
    return _instance.collection("users").doc(id).get().then((DocumentSnapshot data){
      UserData.first = data['name']['first'];
      UserData.last = data['name']['last'];
      UserData.email = data['name']['email'];
      UserData.subjectRefs = data['subjects'];
      _getSubjects();
    });
  }

  static _getSubjects() async {
    UserData.subjects = await Future.wait(subjectRefs.map((e) async => await _getSubject(e)));
  }

  static Future<Subject> _getSubject(String docid) async {
    return _instance.collection("subjects").doc(docid).get().then((data) => 
      Subject.data(data)
    );
  }
}