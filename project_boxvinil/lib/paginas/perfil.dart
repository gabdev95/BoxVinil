import 'package:flutter/material.dart';
import './componentes/opcoes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './componentes/navegacao.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final user = FirebaseAuth.instance.currentUser;

  String? nome = '';
<<<<<<< HEAD
  // List listaMusicas = [];
  // DatabaseReference ref = FirebaseDatabase.instance.ref().child('nome');

  deletarCadastro() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.delete();
      // ignore: use_build_context_synchronously
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
=======
>>>>>>> poo

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

                //Imagem de perfil

                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        user!.photoURL ?? "../assets/images/perfil.png"),
                  ),
                ),

                const SizedBox(
                  height: 56,
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
          BarraNavegacao(
            perfilTexto: 'Perfil',
            perfilColorTexto: const Color.fromRGBO(50, 205, 50, 1),
            perfilColorIcon: const Color.fromRGBO(50, 205, 50, 1),
            fnPerfil: () {},
            gerarPlayTexto: 'Gerar Playlist',
            gerarPlayColorTexto: const Color.fromRGBO(248, 250, 255, 1),
            gerarPlayColorIcon: const Color.fromRGBO(248, 250, 255, 1),
            fnGerarPlay: () {
              Navigator.pushNamed(context, '/lista');
            },
            playlistsTexto: 'Playlists',
            playlistsColorTexto: const Color.fromRGBO(248, 250, 255, 1),
            playlistsColorIcon: const Color.fromRGBO(248, 250, 255, 1),
            fnPlaylists: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }

  deletarCadastro() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.delete();
      // ignore: use_build_context_synchronously
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
}
