import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './componentes/campoForm.dart';
import 'componentes/botao_entrar_cadastrar.dart';
import './componentes/hiperlink.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _email = TextEditingController();
  final _senha = TextEditingController();

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
              CampoForm(
                controller: _email,
                obscureText: false,
                hintText: 'Email',
                validator: (_) => null,
              ),

              const SizedBox(
                height: 32.0,
              ),

              // Campo de senha
              CampoForm(
                controller: _senha,
                obscureText: true,
                hintText: 'Senha',
                validator: (_) => null,
              ),

              const SizedBox(
                height: 32.0,
              ),

              // Botão de entrar
              BotaoEntrarCadastrar(
                fn: logar,
                texto: 'Entrar',
              ),

              const SizedBox(
                height: 16,
              ),

              // Hiperlink
              const Hiperlink(
                texto: 'Não possui uma conta?',
                caminho: '/cadastro',
                entrarCadastrar: 'Cadastre-se',
              ),
            ],
          ),
        ),
      ),
    );
  }

  logar() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _senha.text);
      // ignore: use_build_context_synchronously
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
}
