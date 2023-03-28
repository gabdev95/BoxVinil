import 'package:flutter/material.dart';

class BarraNavegacao extends StatelessWidget {
  const BarraNavegacao({
    super.key,
    required this.perfilTexto,
    required this.perfilColorTexto,
    required this.perfilColorIcon,
    required this.fnPerfil,
    required this.gerarPlayTexto,
    required this.gerarPlayColorTexto,
    required this.gerarPlayColorIcon,
    required this.fnGerarPlay,
    required this.playlistsTexto,
    required this.playlistsColorTexto,
    required this.playlistsColorIcon,
    required this.fnPlaylists,
  });

  final String perfilTexto;
  final Color? perfilColorTexto;
  final Color? perfilColorIcon;
  final Function()? fnPerfil;

  final String gerarPlayTexto;
  final Color? gerarPlayColorTexto;
  final Color? gerarPlayColorIcon;
  final Function()? fnGerarPlay;

  final String playlistsTexto;
  final Color? playlistsColorTexto;
  final Color? playlistsColorIcon;
  final Function()? fnPlaylists;

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
                onPressed: fnPlaylists,
                icon: Icon(
                  Icons.save,
                  color: playlistsColorIcon,
                  size: 24,
                ),
              ),
              Text(
                playlistsTexto,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: playlistsColorTexto,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: fnGerarPlay,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: gerarPlayColorIcon,
                  size: 24,
                ),
              ),
              Text(
                gerarPlayTexto,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: gerarPlayColorTexto,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: fnPerfil,
                icon: Icon(
                  Icons.perm_identity,
                  color: perfilColorIcon,
                  size: 24,
                ),
              ),
              Text(
                perfilTexto,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: perfilColorTexto,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
