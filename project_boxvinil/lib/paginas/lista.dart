import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  String realTimeValue = '0';
  String getOnceValue = '0';
  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('count');

    ref.onValue.listen((event) {
      setState(() {
        realTimeValue = event.snapshot.value.toString();
      });
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Real Time Counter: $realTimeValue',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () async {
                final snapshot = await ref.get();
                if (snapshot.exists) {
                  setState(() {
                    getOnceValue = snapshot.value.toString();
                  });
                } else {
                  print('Nenhum dado disponível');
                }
              },
              child: const Text('Botão'),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Real Time Counter: $getOnceValue',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
