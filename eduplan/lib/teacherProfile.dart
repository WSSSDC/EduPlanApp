import 'package:flutter/material.dart';
import 'userdata.dart';

class TeacherProfile extends StatefulWidget {
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  String _newClassCode = "";

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
              onPressed: () {
                
              },
            ),
          )
        ]
    );
  }
}