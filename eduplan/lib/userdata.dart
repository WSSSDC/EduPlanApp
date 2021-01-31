import 'package:cloud_firestore/cloud_firestore.dart';
import 'subject.dart';

class UserData {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  static String id = "5OQbxtjwz8nn3KLMpFRG";
  static String first = "";
  static String last = "";
  static String email = "";
  static bool isStudent = true;
  static List<String> subjectRefs = [];
  static List<Subject> subjects = [];

  static Future<void> getData() {
    return _instance.collection("users").doc(id).get().then((DocumentSnapshot data) async {
      UserData.first = data['name']['first'] ?? "";
      UserData.last = data['name']['last'] ?? "";
      UserData.email = data['name']['email'] ?? "";
      UserData.isStudent = data['isStudent'] ?? true;
      UserData.subjectRefs = List<String>.from(data['subjects']);
      await _getSubjects();
    });
  }

  static Future<void> _getSubjects() async {
    UserData.subjects = await Future.wait(subjectRefs.map((e) async => await _getSubject(e)));
  }

  static Future<Subject> _getSubject(String docid) async {
    return _instance.collection("subjects").doc(docid).get().then((data){ 
        return Subject.data(data);
      }
    );
  }

  static Future<void> setData() {
    if((email ?? "").isNotEmpty)
    _instance.collection("users").doc(id).set({
      'email': email,
    }, SetOptions(merge:true));
    
    return _instance.collection("users").doc(id).set({
      'name': {
        'first': first,
        'last': last,
      },
      'isStudent': isStudent,
      'subjects': subjectRefs
    }, SetOptions(merge:true));
  }

  static addSubject(String code) async {
    subjectRefs.add(code);
    await setData();
    await getData();
  }

  static removeSubject(String code) async {
    subjectRefs.remove(code);
    await setData();
    await getData();
  }
}