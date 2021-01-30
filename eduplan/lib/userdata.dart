import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  static String id = "5OQbxtjwz8nn3KLMpFRG";
  static String first = "";
  static String last = "";
  static String email = "";

  static Future<void> getData() {
    return _instance.collection("users").doc(id).get().then((data){
      UserData.first = data['name']['first'];
      UserData.last = data['name']['last'];
      UserData.email = data['name']['email'];
    });
  }
}