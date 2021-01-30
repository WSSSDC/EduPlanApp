import 'package:eduplan/subject.dart';
import 'package:flutter/material.dart';
import 'userdata.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text(UserData.first + " " + UserData.last),
      ),
      body: ListView(
        children: UserData.subjects.isEmpty ? <Widget>[Text("No Classes")] : UserData.subjects.map((e) {
          return ListTile(
            title: Text(e.title)
          );
        }).toList()
      ),
    );
  }
}