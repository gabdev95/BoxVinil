import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Carregamento extends StatefulWidget {
  const Carregamento({super.key});

  @override
  State<Carregamento> createState() => _CarregamentoState();
}

class _CarregamentoState extends State<Carregamento> {
  @override
  initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamed(context, '/login');
      } else {
        print(user.displayName);
        // Estudar o Navigator, da pra otimizar isso aqui
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            SizedBox(
              width: 256.0,
              height: 190.51,
              child: Image.asset("assets/images/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
