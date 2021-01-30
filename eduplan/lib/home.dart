import 'package:flutter/material.dart';
import 'calendar.dart';
import 'login.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    }
                  )
                );
              }
            ),
            MaterialButton(
              child: Text("Calendar"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Calendar();
                    }
                  )
                );
              }
            ),
            MaterialButton(
              child: Text("Profile"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    }
                  )
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
