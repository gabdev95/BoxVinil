import 'package:flutter/material.dart';

class Opcoes extends StatelessWidget {
  final Widget icone;
  final String texto;
  final Function()? fn;
  const Opcoes({
    super.key,
    required this.fn,
    required this.icone,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(179, 179, 179, 1),
          ),
        ),
      ),
      child: TextButton(
        onPressed: fn,
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              icone,
              const SizedBox(
                width: 38,
              ),
              Text(
                texto,
                style: const TextStyle(
                  color: Color.fromRGBO(179, 179, 179, 1),
                  fontSize: 19.2,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
