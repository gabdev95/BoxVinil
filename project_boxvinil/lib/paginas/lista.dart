import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('spotify')
                  // .where('cluster', isEqualTo: '0')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'Espere um pouco',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot musicas = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(
                          musicas['nome'],
                          style: const TextStyle(
                            color: Color.fromRGBO(179, 179, 179, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 19.2,
                          ),
                        ),
                        subtitle: Text(
                          musicas['artista'],
                          style: const TextStyle(
                            color: Color.fromRGBO(223, 219, 219, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Text(
                          musicas['cluster'],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
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
                                      'Gerando Playlist',
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
                          String cluster = musicas['cluster'];
                          print(cluster);
                          var db =
                              FirebaseFirestore.instance.collection('spotify');
                          db
                              .where('cluster', isEqualTo: cluster)
                              .get()
                              .then((querySnapshot) {
                            print('Sucesso');
                            List listaMusicas = [];
                            for (var docSnapshot in querySnapshot.docs) {
                              // print('${docSnapshot.data()['nome']}');
                              listaMusicas.add(docSnapshot.data()['nome']);
                            }
                            // print(musicas);
                            final random = Random();
                            List playlist = [];
                            for (int i = 0; i < 10; i++) {
                              var musica = listaMusicas[
                                  random.nextInt(listaMusicas.length)];
                              print(musica);
                              if (playlist.contains(musica)) {
                                i -= 1;
                              } else {
                                playlist.add(musica);
                              }
                            }
                            print(playlist);
                            Navigator.pushNamed(
                              context,
                              '/playlist',
                              arguments: playlist,
                            );
                          });
                        },
                      );
                    },
                  );
                }
              },
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
                        Navigator.pushNamed(context, '/home');
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
                        color: Color.fromRGBO(50, 205, 50, 1),
                        size: 24,
                      ),
                    ),
                    const Text(
                      'Gerar Playlist',
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
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     const SizedBox(
      //       height: 48,
      //     ),
      //     Text(
      //       'Foram retornadas: ${listaMusicas.length.toString()} músicas',
      //       style: const TextStyle(
      //         color: Colors.white,
      //         fontSize: 16,
      //       ),
      //     ),
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: listaMusicas.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             title: Text(
      //               listaMusicas[index],
      //               style: const TextStyle(
      //                 color: Colors.white,
      //               ),
      //             ),
      //             onTap: () {},
      //           );
      //         },
      //       ),
      //     ),
      //     Container(
      //       height: 72,
      //       width: double.infinity,
      //       decoration: const BoxDecoration(
      //         color: Color.fromRGBO(36, 36, 36, 1),
      //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Column(
      //             children: [
      //               IconButton(
      //                 onPressed: () {
      //                   Navigator.pushNamed(context, '/home');
      //                 },
      //                 icon: const Icon(
      //                   Icons.save,
      //                   color: Color.fromRGBO(248, 250, 255, 1),
      //                   size: 24,
      //                 ),
      //               ),
      //               const Text(
      //                 'Playlists',
      //                 style: TextStyle(
      //                   fontFamily: 'Roboto',
      //                   fontSize: 12,
      //                   fontWeight: FontWeight.w400,
      //                   color: Color.fromRGBO(248, 250, 255, 1),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               IconButton(
      //                 onPressed: () {},
      //                 icon: const Icon(
      //                   Icons.add_circle_outline,
      //                   color: Color.fromRGBO(50, 205, 50, 1),
      //                   size: 24,
      //                 ),
      //               ),
      //               const Text(
      //                 'Gerar Playlist',
      //                 style: TextStyle(
      //                   fontFamily: 'Roboto',
      //                   fontSize: 12,
      //                   fontWeight: FontWeight.w400,
      //                   color: Color.fromRGBO(50, 205, 50, 1),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               IconButton(
      //                 onPressed: () {
      //                   Navigator.pushNamed(context, '/perfil');
      //                 },
      //                 icon: const Icon(
      //                   Icons.perm_identity,
      //                   color: Color.fromRGBO(248, 250, 255, 1),
      //                   size: 24,
      //                 ),
      //               ),
      //               const Text(
      //                 'Perfil',
      //                 style: TextStyle(
      //                   fontFamily: 'Roboto',
      //                   fontSize: 12,
      //                   fontWeight: FontWeight.w400,
      //                   color: Color.fromRGBO(248, 250, 255, 1),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  body() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('spotify').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('Espere um pouco');
        } else {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              DocumentSnapshot musicas = snapshot.data!.docs[index];
              return Text(
                '${musicas['nome']} | ${musicas['artista']}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              );
            },
          );
        }
      },
    );
  }
}
