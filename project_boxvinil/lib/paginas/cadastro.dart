import 'package:flutter/material.dart';

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

  void cadastrar() {
    final form = _formKey.currentState;
    if (form!.validate()) {}
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
                    onPressed: () {},
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
