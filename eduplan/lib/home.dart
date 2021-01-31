import 'package:eduplan/loginHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'calendar.dart';
import 'login.dart';
import 'profile.dart';
import 'userdata.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextStyle _style = TextStyle(
    fontSize: 32
  );

  @override
  void initState() {
    UserData.id = _auth.currentUser.uid;
    UserData.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EduPlan"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(height: 25),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Calendar", style: _style),
                    Container(width: 10),
                    Icon(Icons.calendar_today)
                  ],
                ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Profile", style: _style),
                    Container(width: 10),
                    Icon(Icons.person)
                  ],
                ),
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
            ),
            Expanded(
              child: Container(),
            ),
            MaterialButton(
              child: Text("Log Out"),
              onPressed: () {
                LoginHandler.signOut().then((_){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return Login();
                      }
                    )
                  );
                });
              }
            ),
            Container(height: 25)
          ],
        ),
      ),
    );
  }
}
