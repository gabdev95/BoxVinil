import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  // Chave para pegar o email está aqui
  final user = FirebaseAuth.instance.currentUser;

  String? nome = '';

  @override
  Widget build(BuildContext context) {
    nome = user!.displayName;
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
              stream:
                  FirebaseFirestore.instance.collection('playlist').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'Não há playlists salvas',
                    style: TextStyle(
                        color: Color.fromRGBO(248, 250, 255, 1),
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  );
                }
                // Todas as playlists da coleção playlists
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
                          dbPlaylist
                              .where('nome', isEqualTo: playlist['nome'])
                              .get()
                              .then((querySanpshot) {
                            List musicas = [];
                            List artistas = [];
                            List idRefMusicas = [];

                            for (var docSnapshot in querySanpshot.docs) {
                              musicas = docSnapshot.data()['lista'];
                              artistas = docSnapshot.data()['artistas'];
                              // Lista com o docId das músicas da coleção spotify
                              idRefMusicas = docSnapshot.data()['musicas'];
                            }

                            // teste(id);

                            Navigator.pushNamed(
                              context,
                              '/playlist',
                              arguments: {
                                'titulo': playlist['nome'],
                                'idRefMusicas': idRefMusicas,
                                'docId': docIdPlaylist,
                                'lista': musicas,
                                'artistas': artistas,
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.save,
                        color: Color.fromRGBO(50, 205, 50, 1),
                        size: 24,
                      ),
                    ),
                    const Text(
                      'Playlists',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(50, 205, 50, 1),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/lista');
                      },
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/perfil');
                      },
                      icon: const Icon(
                        Icons.perm_identity,
                        color: Color.fromRGBO(248, 250, 255, 1),
                        size: 24,
                      ),
                    ),
                    const Text(
                      'Perfil',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(248, 250, 255, 1),
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

  Future teste(id) async {
    var nomeMusicas = <Future>[];
    var nomeArtistas = <Future>[];
    var dbSpotify = FirebaseFirestore.instance.collection('spotify');

    for (var index = 0; index < 10; index++) {
      var docRef = dbSpotify.doc(id[index]);
      docRef.get().then((docSnapshot) {
        if (docSnapshot.exists) {
          var data = docSnapshot.data();
          nomeMusicas.add(data!['nome']);
          nomeArtistas.add(data['artista']);
          return nomeMusicas;
        } else {
          print('Documento não foi encontrado');
        }
        // Fora daqui não consigo mais acessar nomeMusicas ou nomeArtistas
        print(nomeMusicas);
      });
    }
    await Future.wait(nomeMusicas);
    await Future.wait(nomeArtistas);
    print(nomeMusicas);
    print(nomeArtistas);
  }
}
