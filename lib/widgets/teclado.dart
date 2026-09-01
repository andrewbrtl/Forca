import 'package:flutter/material.dart';

class Teclado extends StatelessWidget {
  final List<String> usadas;
  final void Function(String letra)? onLetra;

  const Teclado({super.key, required this.usadas, this.onLetra});

  Widget _buildBotaoFundo(bool usada) {
    return Opacity(
      opacity: usada
          ? 0.4
          : 1.0, //Aqui na hora de contruir cada botao ele ja recebe se ele ja foi usado ou nao, a verificacao fica no outro widget
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
        for (String letra in letras) //Gera todas as letras
          SizedBox(
            width: 52,
            height: 52,
            child: InkWell(
              onTap: usadas.contains(letra)
                  ? null
                  : () => onLetra?.call(
                      letra,
                    ), //chama a funcao callback do forca_poage.
              child: Stack(
                //Denovo stack pra poder combinas duas imagens a do fundo e a da letra, assim evita ter q ter o dobro de asset.
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
