import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './componentes/navegacao.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 48,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Selecione uma música',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(248, 250, 255, 1),
                fontFamily: 'Roboto',
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('spotify').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(50, 205, 50, 1),
                      strokeWidth: 10.0,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot musicas = snapshot.data!.docs[index];
                      return ListTile(
                        leading: Container(
                          height: 51,
                          width: 51,
                          color: const Color.fromRGBO(223, 219, 219, 1),
                        ),
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
                          // Armazena o cluster da música clicada
                          String cluster = musicas['cluster'];
                          var db =
                              FirebaseFirestore.instance.collection('spotify');
                          db
                              .where('cluster', isEqualTo: cluster)
                              .get()
                              .then((querySnapshot) {
                            List listaMusicas = [];
                            List listaArtistas = [];
                            List listaId = [];
                            for (var docSnapshot in querySnapshot.docs) {
                              // Todas as músicas do cluster armazenado
                              listaMusicas.add(docSnapshot.data()['nome']);
                              // Todas os artistas do cluster armazenado
                              listaArtistas.add(docSnapshot.data()['artista']);
                              // Todos os id do cluster armazenado
                              listaId.add(docSnapshot.id);
                            }
                            final random = Random();
                            List playlist = [];
                            List artistas = [];
                            // List ids = [];
                            var listaRef = [];
                            for (int i = 0; i < 10; i++) {
                              var index = random.nextInt(listaMusicas.length);
                              var musica = listaMusicas[index];
                              var artista = listaArtistas[index];
                              var id = listaId[index];
                              DocumentReference musicasRef = db.doc(id);

                              if (listaRef.contains(musicasRef)) {
                                i -= 1;
                              } else {
                                playlist.add(musica);
                                artistas.add(artista);
                                // ids.add(id);
                                listaRef.add(musicasRef);
                              }
                            }
                            Navigator.pushNamed(
                              context,
                              '/salvar',
                              arguments: {
                                'playlist': playlist,
                                'artistas': artistas,
                                // 'id': ids,
                                'referencias': listaRef,
                              },
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
          BarraNavegacao(
            perfilTexto: 'Perfil',
            perfilColorTexto: const Color.fromRGBO(248, 250, 255, 1),
            perfilColorIcon: const Color.fromRGBO(248, 250, 255, 1),
            fnPerfil: () {
              Navigator.pushNamed(context, '/perfil');
            },
            gerarPlayTexto: 'Gerar Playlist',
            gerarPlayColorTexto: const Color.fromRGBO(50, 205, 50, 1),
            gerarPlayColorIcon: const Color.fromRGBO(50, 205, 50, 1),
            fnGerarPlay: () {},
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
}
