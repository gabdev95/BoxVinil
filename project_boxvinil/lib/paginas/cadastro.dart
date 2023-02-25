import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmaSenha = TextEditingController();
  final _nome = TextEditingController();

  void cadastrar() async {
    final form = _formKey.currentState;
    if (form!.validate()) {}
    if (_senha.text == _confirmaSenha.text) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email.text, password: _senha.text);
        // Pop-up
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              height: 40,
              width: 240,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(94, 242, 94, 1),
                  borderRadius: BorderRadius.circular(100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle_outline_rounded),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Cadastro Realizado',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        User? user = userCredential.user;
        await user?.updateDisplayName(_nome.text);

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
        if (err.code == 'weak-password') {
          print('Digite uma senha mais forte');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Digite uma senha mais forte'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (err.code == 'email-already-in-use') {
          print('Email já está em uso');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Este email já está em uso'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 154,
              ),

              const SizedBox(
                width: 296,
                child: Text(
                  'Digite seu e-mail',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(248, 250, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              // Campo de email
              TextFormField(
                controller: _email,
                obscureText: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(248, 250, 255, 1),
                  hintText: 'Ex.: joao@email.com',
                  contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints:
                      const BoxConstraints(maxWidth: 296, maxHeight: 60),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Preencha o campo email';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              const SizedBox(
                width: 296,
                child: Text(
                  'Digite sua senha',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(248, 250, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              // Campo de senha
              TextFormField(
                controller: _senha,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(248, 250, 255, 1),
                  hintText: '........',
                  contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints:
                      const BoxConstraints(maxWidth: 296, maxHeight: 60),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Preencha o campo senha';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              const SizedBox(
                width: 296,
                child: Text(
                  'Confirme sua senha',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(248, 250, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              // Campo de confirme sua senha
              TextFormField(
                controller: _confirmaSenha,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(248, 250, 255, 1),
                  hintText: '........',
                  contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints:
                      const BoxConstraints(maxWidth: 296, maxHeight: 60),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Preencha o campo confirme sua senha';
                  }
                  if (value != _senha.text) {
                    return 'As senhas são diferentes';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              const SizedBox(
                width: 296,
                child: Text(
                  'Como você gostaria de ser chamado?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(248, 250, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              // Campo de nome
              TextFormField(
                controller: _nome,
                obscureText: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(248, 250, 255, 1),
                  hintText: 'Ex.: Joao',
                  contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints:
                      const BoxConstraints(maxWidth: 296, maxHeight: 60),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Preencha o campo nome';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 32,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(50, 205, 50, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(296, 40),
                ),
                onPressed: cadastrar,
                child: const Text(
                  'Cadastrar',
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
                    'Já possui conta?',
                    style: TextStyle(
                      color: Color.fromRGBO(248, 250, 255, 1),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  // Hyperlink Entrar
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Color.fromRGBO(248, 250, 255, 1),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.underline,
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
