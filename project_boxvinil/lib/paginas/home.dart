import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './componentes/navegacao.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final user = FirebaseAuth.instance.currentUser;

  String? nome = '';
  String? email = '';

  @override
  Widget build(BuildContext context) {
    nome = user!.displayName;
    email = user!.email;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Olá, $nome!',
                      style: const TextStyle(
                        color: Color.fromRGBO(248, 250, 255, 1),
                        fontFamily: 'Roboto',
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/lista');
                        },
                        backgroundColor: const Color.fromRGBO(50, 205, 50, 1),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                          color: Color.fromRGBO(24, 24, 24, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Suas playlists salvas',
                  style: TextStyle(
                    color: Color.fromRGBO(248, 250, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 19.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('playlist')
                  .where('usuario', isEqualTo: email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                // Todas as playlists da coleção playlists do usuário logado
                List playlists = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    // Informações de cada playlist
                    DocumentSnapshot playlist = playlists[index];
                    // Pegando id do documento da coleção playlist
                    var docIdPlaylist = playlist.id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34),
                      child: TextButton(
                        onPressed: () {
                          var dbPlaylist =
                              FirebaseFirestore.instance.collection('playlist');
                          dbPlaylist.get().then((querySanpshot) {
                            List idRefMusicas = [];

                            for (var docSnapshot in querySanpshot.docs) {
                              idRefMusicas = docSnapshot.data()['musicas'];
                            }

                            Navigator.pushNamed(
                              context,
                              '/playlist',
                              arguments: {
                                'titulo': playlist['nome'],
                                'idRefMusicas': idRefMusicas,
                                'docId': docIdPlaylist,
                              },
                            );
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              playlist['nome'],
                              style: const TextStyle(
                                  fontSize: 19.2,
                                  color: Color.fromRGBO(179, 179, 179, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color.fromRGBO(50, 205, 50, 1),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Barra de navegação
          BarraNavegacao(
            perfilTexto: 'Perfil',
            perfilColorTexto: const Color.fromRGBO(248, 250, 255, 1),
            perfilColorIcon: const Color.fromRGBO(248, 250, 255, 1),
            fnPerfil: () {
              Navigator.pushNamed(context, '/perfil');
            },
            gerarPlayTexto: 'Gerar Playlist',
            gerarPlayColorTexto: const Color.fromRGBO(248, 250, 255, 1),
            gerarPlayColorIcon: const Color.fromRGBO(248, 250, 255, 1),
            fnGerarPlay: () {
              Navigator.pushNamed(context, '/lista');
            },
            playlistsTexto: 'Playlists',
            playlistsColorTexto: const Color.fromRGBO(50, 205, 50, 1),
            playlistsColorIcon: const Color.fromRGBO(50, 205, 50, 1),
            fnPlaylists: () {},
          ),
        ],
      ),
    );
  }
}
