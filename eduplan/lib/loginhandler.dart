import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userdata.dart';

class LoginHandler {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn;
  static User _credential;

  static signInWithGoogle() async {
    _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    List<String> _name = googleSignInAccount.displayName.split(' ');
    UserData.first = _name[0];
    UserData.last = _name[1];
    //photoURL = googleSignInAccount.photoUrl;
    UserData.email = googleSignInAccount.email;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    _credential = userCredential.user;
    UserData.id = _credential.uid;
    await UserData.getData();
    await UserData.setData();
  }

  static signOut() async {
    UserData.first = "";
    UserData.last = "";
    UserData.email = "";
    UserData.subjectRefs = [];
    UserData.subjects = [];
    await _firebaseAuth.signOut();
  }
}

