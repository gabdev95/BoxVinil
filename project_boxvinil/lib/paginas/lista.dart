import 'package:flutter/material.dart';

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  @override
  Widget build(BuildContext context) {
    List listaMusicas = ModalRoute.of(context)?.settings.arguments as List;

    return Scaffold(
      // body: Text(argumentos.toString()),
      body: ListView.builder(
        itemCount: listaMusicas.length,
        // 113999
        // Não é o número de músicas que está deixando o app lento
        // Provavelmente é a forma de pegar os dados, o listen
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              listaMusicas[index],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
