import 'package:eduplan/loginHandler.dart';
import 'package:flutter/material.dart';
import 'userdata.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isStudent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Are you a Student?"),
                Checkbox(
                  value: _isStudent,
                  onChanged: (v) => setState(() => _isStudent = v),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: MaterialButton(
                  child: Text("Sign in with Google", style: TextStyle(
                    fontSize: 32
                  )),
                  onPressed: () {
                    UserData.isStudent = _isStudent;
                    LoginHandler.signInWithGoogle().then((_){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Home()
                        )
                      );
                    });
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}