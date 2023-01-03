import 'package:flutter/material.dart';
import 'package:project_boxvinil/screens/login_screen.dart';

// Classe da Tela de Registro/Cadastro
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),

        child: ListView(
          children: <Widget>[
            const SizedBox(height: 100,),

            // TextFormField E-mail
            const Text(
              'Digite seu e-mail',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 1.0),
                hintText: "Ex.: joao@email.com",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            const SizedBox(height: 20,),

            // TextFormField Username
            const Text(
              'Digite um Username',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 1.0),
                hintText: "Ex.: joao95",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            const SizedBox(height: 20,),

            // TextFormField senha
              const Text(
                'Digite uma senha',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 1.0),
                  hintText: "........",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 25),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              const SizedBox(height: 20,),

            // TextFormField confirmar senha
              const Text(
                'Confirme sua senha',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 1.0),
                  hintText: "........",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 25),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              const SizedBox(height: 20,),

            // TextFormField Apelido
            const Text(
              'Como você gostaria de ser chamado?',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 1.0),
                hintText: "Ex.: Joao",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            const SizedBox(height: 30,),

            // Button Cadastrar
            Container(
              height: 41.0,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 50, 205, 50),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Cadastrar",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                  // Adcionar function que redireciona a tela principal
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 17,),

            // Redireciona para screen login
            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget> [
                      Text.rich(
                        TextSpan(
                          text: "Já possui uma conta? ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Entrar",
                              style: TextStyle(decoration: TextDecoration.underline)
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
}}