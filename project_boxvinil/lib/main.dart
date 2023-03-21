import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import './paginas/cadastro.dart';
import './paginas/configuracoes.dart';
import './paginas/login.dart';
import './paginas/perfil.dart';
import 'paginas/home.dart';
import './paginas/carregamento.dart';
import './paginas/lista.dart';
import './paginas/playlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BoxVinil",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 24, 24),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Carregamento(),
        '/cadastro': (context) => const TelaCadastro(),
        '/login': (context) => const TelaLogin(),
        '/home': (context) => const TelaHome(),
        '/perfil': (context) => const TelaPerfil(),
        '/configuracao': (context) => const TelaConfiguracao(),
        '/lista': (context) => const TelaLista(),
        '/playlist': (context) => const TelaPlaylist(),
      },
    );
  }
}
