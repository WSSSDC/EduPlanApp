import 'package:flutter/material.dart';
import 'userdata.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
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
                onPressed: (){
                  UserData.removeSubject(e.id).then((_){
                    setState(() {});
                  });
                },
              ),
            );
          }).toList())) + <Widget>[
          ListTile(
            title: TextField(
              decoration: InputDecoration(
                labelText: 'Class Code'
              ), 
              onChanged: (v) => _newClassCode = v,
            ),
            trailing: MaterialButton(
              child: Icon(Icons.add),
              onPressed: (){
                UserData.addSubject(_newClassCode).then((){
                  setState(() {});
                });
              }
            ),
          )
        ]
    );
  }
}