import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import './componentes/campoForm.dart';
import './componentes/botao_entrar_cadastrar.dart';

class TelaConfiguracao extends StatefulWidget {
  const TelaConfiguracao({super.key});

  @override
  State<TelaConfiguracao> createState() => _TelaConfiguracaoState();
}

class _TelaConfiguracaoState extends State<TelaConfiguracao> {
  var user = FirebaseAuth.instance.currentUser;
  File? _imageFile;
  String? nome = '';
  final FirebaseStorage storage = FirebaseStorage.instance;

  final _nome = TextEditingController();

  void initState() {
    super.initState();
    _imageFile = File(user?.photoURL ?? "../assets/images/perfil.png");
    // _nome.text = user?.displayName ?? "";
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<void> _uploadUser() async {
    if (_imageFile == null) return;

    XFile file = XFile(_imageFile!.path);
    try {
      String ref = 'images/${user?.uid}.jpg';
      var task = await storage.ref(ref).putData(await file.readAsBytes());

      String downloadUrl = await task.ref.getDownloadURL();
      await user?.updatePhotoURL(downloadUrl);
      await user?.updateDisplayName(_nome.text);
      Navigator.pushNamed(context, '/perfil');
      return;
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  @override
  Widget build(BuildContext context) {
    nome = user!.displayName;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
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
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Olá, $nome!',
              style: const TextStyle(
                color: Color.fromRGBO(248, 250, 255, 1),
                fontSize: 23,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 23,
                ),

                // Imagem de perfil

                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        _imageFile!.path ?? "../assets/images/perfil.png"),
                    radius: 80,
                  ),
                ),

                // Pick Image
                Column(
                  children: [
                    TextButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(
                        Icons.image,
                        size: 16,
                        color: Color.fromRGBO(179, 179, 179, 1),
                      ),
                      label: const Text(
                        "Atualizar imagem",
                        style: TextStyle(
                          color: Color.fromRGBO(179, 179, 179, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                  ],
                ),

                const SizedBox(
                  width: 296,
                  child: Text(
                    'Alterar seu nome',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(248, 250, 255, 1),
                      fontFamily: 'Roboto',
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                // Campo de Alterar nome
                CampoForm(
                  controller: _nome,
                  obscureText: false,
                  hintText: 'Ex.: Joao',
                  validator: (_) => null,
                ),

                const SizedBox(
                  height: 42,
                ),

                // Botão de salvar
                BotaoEntrarCadastrar(
                  fn: () async {
                    if (_nome.text != '') {
                      _uploadUser();
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
                    } else {
                      print('Nome não pode estar vazio');
                    }
                  },
                  texto: 'Salvar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
