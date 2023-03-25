import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    List nomeMusicas = argumentos['lista'];
    List nomeArtistas = argumentos['artistas'];

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
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Excluir playlist'),
                        content: const Text(
                            'Essa playlist será excluída da sua aba de playlists salvas, você está ciente disso?'),
                        actions: [
                          Container(
                            height: 33,
                            width: 50,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              width: 3,
                              color: Colors.red,
                            ))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Não',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(50, 205, 50, 1),
                              ),
                            ),
                            onPressed: () {
                              final docPlaylist = FirebaseFirestore.instance
                                  .collection('playlist');

                              docPlaylist.doc(docId).delete();

                              Navigator.pushNamed(context, '/home');
                            },
                            child: const Text(
                              'Sim',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Color.fromRGBO(179, 179, 179, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: FutureBuilder(
              future: Future.wait(
                  [getNomeMusicas(idMusicas), getNomeArtistas(idMusicas)]),
              builder: (context, musicaSnapshot) {
                if (!musicaSnapshot.hasData) {
                  return CircularProgressIndicator();
                }
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
          // Expanded(
          //   child: StreamBuilder(
          //     stream:
          //         FirebaseFirestore.instance.collection('playlist').snapshots(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return CircularProgressIndicator();
          //       } else {
          //         List playlists = snapshot.data!.docs;

          //         return FutureBuilder(
          //           future: Future.wait([
          //             getNomeMusicas(idMusicas),
          //             getNomeArtistas(idMusicas)
          //           ]),
          //           builder: (context, musicaSnapshot) {
          //             if (!musicaSnapshot.hasData) {
          //               return CircularProgressIndicator();
          //             }
          //             List musicas = musicaSnapshot.data![0];
          //             List artistas = musicaSnapshot.data![1];
          //             return ListView.builder(
          //               itemCount: musicas.length,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   title: Text(
          //                     musicas[index],
          //                     style: const TextStyle(
          //                       color: Color.fromRGBO(179, 179, 179, 1),
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 19.2,
          //                     ),
          //                   ),
          //                   subtitle: Text(
          //                     artistas[index],
          //                     style: const TextStyle(
          //                       color: Color.fromRGBO(223, 219, 219, 1),
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 12,
          //                     ),
          //                   ),
          //                 );
          //               },
          //             );
          //           },
          //         );
          //       }
          //     },
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: idMusicas.length,
          //     itemBuilder: (context, index) {
          //       DocumentSnapshot id = idMusicas[index];

          //       // List musicaRefs = List.from(playlist.get('musicas'));

          //       return FutureBuilder(
          //         future: getNome(idMusicas),
          //         builder: (context, musicaSnapshot) {
          //           if (!musicaSnapshot.hasData) {
          //             return Text('Aguardando');
          //           }
          //           List musicas = musicaSnapshot.data as List;
          //           print(musicas);
          //           return ListTile(
          //             title: Text(musicas[index]),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
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
