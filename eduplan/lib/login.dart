import 'package:flutter/material.dart';
import 'profile.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EduPlan"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Please Login or Sign Up"),
            MaterialButton(
              child: Text("Login"),
              onPressed: () {
                /*Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    }
                  )
                );*/
              }
            )
          ],
        ),
      ),
    );
  }
}
