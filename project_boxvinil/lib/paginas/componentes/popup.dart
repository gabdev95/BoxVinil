import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
                  final docPlaylist =
                      FirebaseFirestore.instance.collection('playlist');

                  docPlaylist.doc(id).delete();

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
    );
  }
}
