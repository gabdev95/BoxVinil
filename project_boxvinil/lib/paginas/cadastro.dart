import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './componentes/campoForm.dart';
import './componentes/botao_entrar_cadastrar.dart';
import './componentes/hiperlink.dart';
import './componentes/label_form_cadastro.dart';

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

              const Label(label: 'Digite seu e-mail'),

              const SizedBox(
                height: 8,
              ),

              // Campo de email
              CampoForm(
                controller: _email,
                obscureText: false,
                hintText: 'Ex.: joao@email.com',
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

              const Label(label: 'Digite sua senha'),

              const SizedBox(
                height: 8,
              ),

              // Campo de senha
              CampoForm(
                controller: _senha,
                obscureText: true,
                hintText: '........',
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

              const Label(label: 'Confirme sua senha'),

              const SizedBox(
                height: 8,
              ),

              // Campo de confirme sua senha
              CampoForm(
                controller: _confirmaSenha,
                obscureText: true,
                hintText: '........',
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

              const Label(label: 'Como você gostaria de ser chamado?'),

              const SizedBox(
                height: 8,
              ),

              // Campo de nome
              CampoForm(
                controller: _nome,
                obscureText: false,
                hintText: 'Ex.: Joao',
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

              // Botão de cadastrar
              BotaoEntrarCadastrar(
                fn: cadastrar,
                texto: 'Cadastrar',
              ),

              const SizedBox(
                height: 16,
              ),

              // Hiperlink
              const Hiperlink(
                texto: 'Já possui conta?',
                caminho: '/login',
                entrarCadastrar: 'Entrar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void cadastrar() async {
    final form = _formKey.currentState;
    if (form!.validate()) {}
    if (_senha.text == _confirmaSenha.text) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email.text, password: _senha.text);
        // Pop-up
        // ignore: use_build_context_synchronously
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
}
