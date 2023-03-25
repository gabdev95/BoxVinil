import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaSalvarPlaylist extends StatefulWidget {
  const TelaSalvarPlaylist({super.key});

  @override
  State<TelaSalvarPlaylist> createState() => _TelaSalvarPlaylistState();
}

class _TelaSalvarPlaylistState extends State<TelaSalvarPlaylist> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> argumentos =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    List playlist = argumentos['playlist'];
    List artistas = argumentos['artistas'];
    List id = argumentos['id'];
    List musicas = argumentos['referencias'];
    final titulo = TextEditingController();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Text(
              'Título da Playlist',
              style: TextStyle(
                color: Color.fromRGBO(243, 241, 244, 1),
                fontWeight: FontWeight.w400,
                fontSize: 19.2,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: TextFormField(
              controller: titulo,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Digite o nome da playlist',
                fillColor: const Color.fromRGBO(248, 250, 255, 1),
                contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                constraints: const BoxConstraints(
                  maxWidth: 296,
                  maxHeight: 60,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    playlist[index],
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
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text(
                  'Não Salvar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromRGBO(50, 205, 50, 1),
                  ),
                ),
                onPressed: () {
                  if (titulo.text.isEmpty) {
                    return;
                  } else {
                    final docPlaylist =
                        FirebaseFirestore.instance.collection('playlist').doc();

                    docPlaylist.set({
                      'nome': titulo.text,
                      'lista': playlist,
                      'artistas': artistas,
                      'musicas': musicas,
                    });

                    Navigator.pushNamed(context, '/home');
                  }
                },
                child: const Text(
                  'Salvar Playlist',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
