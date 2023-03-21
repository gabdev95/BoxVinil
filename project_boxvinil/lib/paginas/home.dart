import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final user = FirebaseAuth.instance.currentUser;

  String? nome = '';
  List listaMusicas = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('nome');

  getNomesMusicas() async {
    final snapshot = await ref.get();
    if (snapshot.exists) {
      setState(() {
        listaMusicas = snapshot.value as List;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        context,
        '/lista',
        arguments: listaMusicas,
      );
    } else {
      print('Nenhum dado disponível');
    }
  }

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
                        onPressed: getNomesMusicas,
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
                const Text(
                  'Não há playlists salvas',
                  style: TextStyle(
                      color: Color.fromRGBO(248, 250, 255, 1),
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
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
}
