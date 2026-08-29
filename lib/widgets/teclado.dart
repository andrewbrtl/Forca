import 'package:flutter/material.dart';

class Teclado extends StatefulWidget {
  final void Function(String letra)? onLetra;

  const Teclado({super.key, this.onLetra});

  @override
  State<Teclado> createState() => _TecladoState();
}

class _TecladoState extends State<Teclado> {
  Widget _buildBotaoFundo(bool usada) {
    return Image.asset(
      'assets/letras/botao.png',
      width: 52,
      height: 52,
      fit: BoxFit.contain,
      color: usada ? Colors.black.withValues(alpha: 0.5) : null,
      colorBlendMode: BlendMode.dstATop,
    );
  }

  final List<String> letras = [
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
            child: InkWell(
              onTap: usadas.contains(letra) ? null : () => apertarLetra(letra),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildBotaoFundo(usadas.contains(letra)),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Opacity(
                      opacity: usadas.contains(letra) ? 0.3 : 1.0,
                      child: Image.asset(
                        caminhoImagem(letra),
                        filterQuality: FilterQuality.medium,
                      ),
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
