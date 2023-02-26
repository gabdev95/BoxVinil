import 'package:flutter/material.dart';
import './componentes/opcoes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final user = FirebaseAuth.instance.currentUser;

  String? nome = '';

  deletarCadastro() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.delete();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 40,
            width: 240,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(209, 0, 0, 1),
                borderRadius: BorderRadius.circular(100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.error_outline),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Cadastro Excluído',
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
    } on FirebaseAuthException catch (err) {
      if (err.code == 'requires-recent-login') {
        print(
            'Esta operação é sensível e requer uma nova autenticação. Por favor faça o login novamente!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Esta operação é sensível e requer uma nova autenticação. Por favor faça o login novamente!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    nome = user!.displayName;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 86,
                ),
                Text(
                  'Olá, $nome!',
                  style: const TextStyle(
                    color: Color.fromRGBO(248, 250, 255, 1),
                    fontSize: 23,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),

                // Opção de CONFIGURAÇÕES
                Opcoes(
                  fn: () {
                    Navigator.pushNamed(context, '/configuracao');
                  },
                  icone: const Icon(
                    Icons.settings,
                    size: 24,
                    color: Color.fromRGBO(179, 179, 179, 1),
                  ),
                  texto: 'Configurações',
                ),

                // Opção de DELETAR CADASTRO
                Opcoes(
                    fn: deletarCadastro,
                    icone: const Icon(
                      Icons.delete,
                      size: 24,
                      color: Color.fromRGBO(179, 179, 179, 1),
                    ),
                    texto: 'Deletar cadastro'),

                // Opção de SAIR
                Opcoes(
                  fn: () async {
                    await FirebaseAuth.instance.signOut().then(
                          (user) => Navigator.pushNamed(context, '/'),
                        );
                  },
                  icone: const Icon(
                    Icons.logout,
                    size: 24,
                    color: Color.fromRGBO(179, 179, 179, 1),
                  ),
                  texto: 'Sair',
                ),
              ],
            ),
          ),
          Container(
            height: 72,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(36, 36, 36, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/playlist');
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Color.fromRGBO(248, 250, 255, 1),
                        size: 24,
                      ),
                    ),
                    const Text(
                      'Playlists',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(248, 250, 255, 1),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Color.fromRGBO(248, 250, 255, 1),
                        size: 24,
                      ),
                    ),
                    const Text(
                      'Gerar Playlist',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(248, 250, 255, 1),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.perm_identity,
                        color: Color.fromRGBO(50, 205, 50, 1),
                        size: 24,
                      ),
                    ),
                    const Text(
                      'Perfil',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(50, 205, 50, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
