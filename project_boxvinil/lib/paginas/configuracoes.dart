import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaConfiguracao extends StatefulWidget {
  const TelaConfiguracao({super.key});

  @override
  State<TelaConfiguracao> createState() => _TelaConfiguracaoState();
}

class _TelaConfiguracaoState extends State<TelaConfiguracao> {
  final user = FirebaseAuth.instance.currentUser;

  String? nome = '';

  final _nome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nome = user!.displayName;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 63,
          ),
          IconButton(
            padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
            onPressed: () {
              Navigator.pushNamed(context, '/perfil');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(179, 179, 179, 1),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 23,
                ),

                Text(
                  'Olá, $nome!',
                  style: const TextStyle(
                    color: Color.fromRGBO(248, 250, 255, 1),
                    fontSize: 23,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

                const Text(
                  'Alterar seu nome',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                // Campo de Alterar nome
                TextFormField(
                  controller: _nome,
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(248, 250, 255, 1),
                    hintText: 'Ex.: Joao',
                    contentPadding: const EdgeInsets.fromLTRB(22, 8, 0, 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    constraints:
                        const BoxConstraints(maxWidth: 296, maxHeight: 40),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // Botão de salvar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(50, 205, 50, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size(296, 40),
                  ),
                  onPressed: () async {
                    if (_nome.text != '') {
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
                                  'Alteração Realizada',
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
                      User? user = FirebaseAuth.instance.currentUser;
                      await user?.updateDisplayName(_nome.text);
                      Navigator.pushNamed(context, '/perfil');
                    } else {
                      print('Nome não pode estar vazio');
                    }
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 19.2,
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(248, 250, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
