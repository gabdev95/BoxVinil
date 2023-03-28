import 'package:flutter/material.dart';

class BarraNavegacao extends StatelessWidget {
  const BarraNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
