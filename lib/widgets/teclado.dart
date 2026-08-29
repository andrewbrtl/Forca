import 'package:flutter/material.dart';

class Teclado extends StatefulWidget {
  final void Function(String letra)? onLetra;

  const Teclado({super.key, this.onLetra});

  @override
  State<Teclado> createState() => _TecladoState();
}

class _TecladoState extends State<Teclado> {
  final List<String> letras = [
    "A", "B", "C", "Ç", "D", "E", "F", "G", "H",
    "I", "J", "K", "L", "M", "N", "O", "P", "Q",
    "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
  ];

  final List<String> usadas = [];

  String caminhoImagem(String letra) {
    String nomeArquivo = letra.toUpperCase();
    return 'assets/letras/$nomeArquivo.png';
  }

  void apertarLetra(String letra) {
    setState(() {
      usadas.add(letra);
    });
    widget.onLetra?.call(letra);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: [
        for (String letra in letras)
          SizedBox(
            width: 52,
            height: 52,
            child: ElevatedButton(
              onPressed: usadas.contains(letra)
                  ? null
                  : () => apertarLetra(letra),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey,
              ),
              child: Image.asset(
                caminhoImagem(letra),
                width: 52,
                height: 52,
              ),
            ),
          ),
      ],
    );
  }
}
