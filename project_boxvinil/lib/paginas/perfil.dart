import 'package:flutter/material.dart';
import './componentes/opcoes.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Olá, João!',
                  style: TextStyle(
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
                  fn: () {},
                  icone: const Icon(
                    Icons.settings,
                    size: 24,
                    color: Color.fromRGBO(179, 179, 179, 1),
                  ),
                  texto: 'Configurações',
                ),

                // Opção de DELETAR CADASTRO
                Opcoes(
                    fn: () {},
                    icone: const Icon(
                      Icons.delete,
                      size: 24,
                      color: Color.fromRGBO(179, 179, 179, 1),
                    ),
                    texto: 'Deletar cadastro'),

                // Opção de SAIR
                Opcoes(
                  fn: () {},
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
