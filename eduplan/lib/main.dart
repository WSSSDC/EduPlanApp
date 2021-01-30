import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(Main()));
}

class Main extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EduPlan',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(),
        );
        return CircularProgressIndicator();
      },
    );
  }
}
