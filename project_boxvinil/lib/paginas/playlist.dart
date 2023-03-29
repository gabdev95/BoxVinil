import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './componentes/navegacao.dart';
import './componentes/popup.dart';

class TelaPlaylist extends StatefulWidget {
  const TelaPlaylist({super.key});

  @override
  State<TelaPlaylist> createState() => _TelaPlaylistState();
}

class _TelaPlaylistState extends State<TelaPlaylist> {
  @override
  Widget build(BuildContext context) {
    // Recebendo argumentos da página home
    Map<String, dynamic> argumentos =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    String nomePLaylist = argumentos['titulo'];
    String docId = argumentos['docId'];
    List idMusicas = argumentos['idRefMusicas'];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(243, 241, 244, 1),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nomePLaylist,
                  style: const TextStyle(
                    color: Color.fromRGBO(243, 241, 244, 1),
                    fontSize: 19.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // PopUp para excluir playlist
                PopUp(
                  id: docId,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: FutureBuilder(
              future: Future.wait([
                getNomeMusicas(idMusicas),
                getNomeArtistas(idMusicas),
              ]),
              builder: (context, musicaSnapshot) {
                if (!musicaSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(50, 205, 50, 1),
                      strokeWidth: 10.0,
                    ),
                  );
                }
                // Recebendo os dados dos métodos getNome
                List musicas = musicaSnapshot.data![0];
                List artistas = musicaSnapshot.data![1];
                return ListView.builder(
                  itemCount: musicas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        musicas[index],
                        style: const TextStyle(
                          color: Color.fromRGBO(179, 179, 179, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 19.2,
                        ),
                      ),
                      subtitle: Text(
                        artistas[index],
                        style: const TextStyle(
                          color: Color.fromRGBO(223, 219, 219, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
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
            fnPlaylists: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }

  Future<List<String>> getNomeMusicas(musicaRefs) async {
    List<String> nomeMusicas = [];
    for (var i = 0; i < musicaRefs.length; i++) {
      DocumentSnapshot musicaSnapshot = await musicaRefs[i].get();
      nomeMusicas.add(musicaSnapshot.get('nome'));
    }

    return nomeMusicas;
  }

  Future<List<String>> getNomeArtistas(musicaRefs) async {
    List<String> nomeArtistas = [];
    for (var i = 0; i < musicaRefs.length; i++) {
      DocumentSnapshot musicaSnapshot = await musicaRefs[i].get();
      nomeArtistas.add(musicaSnapshot.get('artista'));
    }

    return nomeArtistas;
  }
}
