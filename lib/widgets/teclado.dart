import 'package:flutter/material.dart';

class Teclado extends StatelessWidget {
  final List<String> usadas;
  final void Function(String letra)? onLetra;

  const Teclado({super.key, required this.usadas, this.onLetra});

  Widget _buildBotaoFundo(bool usada) {
    return Opacity(
      opacity: usada ? 0.4 : 1.0,
      child: Image.asset(
        'assets/letras/botao.png',
        width: 52,
        height: 52,
        fit: BoxFit.contain,
        color: usada ? Colors.black.withValues(alpha: 0.5) : null,
      ),
    );
  }

  static const List<String> letras = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
  ];

  String caminhoImagem(String letra) {
    return 'assets/letras/${letra.toUpperCase()}.png';
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
            child: InkWell(
              onTap: usadas.contains(letra) ? null : () => onLetra?.call(letra),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildBotaoFundo(usadas.contains(letra)),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Opacity(
                      opacity: usadas.contains(letra) ? 0.3 : 1.0,
                      child: Image.asset(caminhoImagem(letra)),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
