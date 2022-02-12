import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notey/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Notey());
}

class Notey extends StatelessWidget {
  const Notey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteApp',
      home: HomePage(),
    );
  }
}
