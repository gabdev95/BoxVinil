import 'package:flutter/material.dart';
import 'package:project_boxvinil/screens/login_screen.dart';
// import 'package:project_boxvinil/screens/register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BoxVinil",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 24, 24), fontFamily: 'Roboto'
      ),
      home: LoginScreen(),
    );
  }
}
