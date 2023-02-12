import 'package:flutter/material.dart';
import './paginas/cadastro.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BoxVinil",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 24, 24),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/cadastro',
      routes: {
        '/cadastro': (context) => const TelaCadastro(),
      },
    );
  }
}
