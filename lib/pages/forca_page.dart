import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_da_forca/widgets/letra_palavra_widget.dart';
import 'package:jogo_da_forca/widgets/teclado.dart';

class ForcaPage extends StatefulWidget {
  const ForcaPage({super.key});

  @override
  State<ForcaPage> createState() => _ForcaPageState();
}

class _ForcaPageState extends State<ForcaPage> {
  final List<String> palavras = [
    'BISTECA',
    'BERNARDO',
    'BURDOGA',
    'KUSTER',
    'RAGUGNETTI',
    'FARTURA',
    'MOTOR',
    'AVIAO',
    'DETONADO',
    'MAGO',
  ];

  late String palavraSorteada;
  List<String> tentativas = [];
  int vidas = 4;

  @override
  void initState() {
    super.initState();
    comecar();
  }

  void comecar() {
    setState(() {
      final random = Random();
      palavraSorteada = palavras[random.nextInt(palavras.length)];
      tentativas.clear();
      vidas = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Image(
          image: AssetImage('assets/titulo.png'),
          fit: BoxFit.fitWidth,
          height: 56,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fundo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 40),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 0,
                    runSpacing: 0,
                    children: palavraSorteada.split('').map((letra) {
                      return LetraSorteadaWidget(
                        letra: letra,
                        revelada: tentativas.contains(letra),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: const Teclado(),
            ),
          ],
        ),
      ),
    );
  }
}
