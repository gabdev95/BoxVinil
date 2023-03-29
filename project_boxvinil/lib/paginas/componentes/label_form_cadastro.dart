import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 296,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Color.fromRGBO(248, 250, 255, 1),
          fontFamily: 'Roboto',
          fontSize: 16,
        ),
      ),
    );
  }
}
