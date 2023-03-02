import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _email = TextEditingController();
  final _senha = TextEditingController();

  logar() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _senha.text);
      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (err) {
      print(err);
      if (err.code == 'invalid-email') {
        print('Formato do email inválido');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Formato do email inválido'),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (err.code == 'user-not-found') {
        print('Usuário não encontrado');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (err.code == 'wrong-password') {
        print('Senha incorreta');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha incorreta'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 152.0,
              ),

              // Logo
              SizedBox(
                width: 256.0,
                height: 190.51,
                child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(
                height: 80.49,
              ),

              // Campo de email
              TextFormField(
                controller: _email,
                obscureText: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(248, 250, 255, 1),
                  hintText: 'Email',
                  contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints: const BoxConstraints(
                    maxWidth: 296,
                    maxHeight: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),

              // Campo de senha
              TextFormField(
                controller: _senha,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(248, 250, 255, 1),
                  hintText: 'Senha',
                  contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints: const BoxConstraints(
                    maxWidth: 296,
                    maxHeight: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),

              // Botão de entrar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(50, 205, 50, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(296, 40),
                ),
                onPressed: logar,
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 19.2,
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(248, 250, 255, 1),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Não possui uma conta?',
                    style: TextStyle(
                      color: Color.fromRGBO(248, 250, 255, 1),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  // Hyperlink Cadastre-se
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro');
                    },
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Color.fromRGBO(248, 250, 255, 1),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.underline,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
