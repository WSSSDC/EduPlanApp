import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'userdata.dart';
import 'subject.dart';

class TeacherProfile extends StatefulWidget {
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  Subject newSubject = new Subject.create("", "", "");

  void _createClass(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                Text("Create a Class"),
                Container(height: 15),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Course Name'
                  ),
                  onChanged: (v) => newSubject.title = v,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Course Code'
                  ),
                  onChanged: (v) => newSubject.courseCode = v,
                ),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text("Add", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                newSubject.id = randomAlpha(5);
                UserData.subjectRefs.add(newSubject.id);
                UserData.subjects.add(newSubject);
                UserData.setData();
                newSubject.setSubject();
                Navigator.of(context).pop();
                setState(() {});
              },
            )
          ],
        );
      }
    );
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await UserData.getData();
    setState(() => UserData);
  }
 
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: (UserData.subjects.isEmpty ? <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text("No Classes", style: TextStyle(
                  fontSize: 32
                )),
              ),
            )
          ] : 
          List<Widget>.from(UserData.subjects.map((e){
            return ListTile(
              title: Text(e.title),
              trailing: MaterialButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  UserData.removeSubject(e.id).then((_){
                    setState(() {});
                  });
                },
              ),
            );
          }).toList())) + <Widget>[
          ListTile(
            title: MaterialButton(
              child: Text("Create a class", style: TextStyle(
                fontSize: 18
              ),),
              onPressed: () => _createClass(context)
            ),
          )
        ]
    );
  }
}