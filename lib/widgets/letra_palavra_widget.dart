import 'package:flutter/material.dart';

class LetraSorteadaWidget extends StatelessWidget {
  final String letra;
  final bool revelada;

  const LetraSorteadaWidget({
    super.key,
    required this.letra,
    required this.revelada,
  });

  @override
  Widget build(BuildContext context) {
    final String nomeArquivo = revelada ? letra.toUpperCase() : 'traco';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Image.asset(
        'assets/letras/$nomeArquivo.png',
        width: 52,
        filterQuality: FilterQuality.medium,
        fit: BoxFit.contain,
        height: 52,
      ),
    );
  }
}
