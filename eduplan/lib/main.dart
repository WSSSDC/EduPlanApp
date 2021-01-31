import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => 
  Firebase.initializeApp().then((_) =>
  runApp(Main())));
}

class Main extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduPlan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _auth.currentUser != null ? Home() : Login(),
    );
  }
}
