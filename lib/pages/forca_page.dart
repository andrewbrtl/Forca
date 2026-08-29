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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forca", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vidas: $vidas',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 0,
                  runSpacing: 0,
                  children: palavraSorteada.split('').map((letra) {
                    return LetraSorteadaWidget(letra: letra, revelada: true);
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: const Teclado(),
          ),
        ],
      ),
    );
  }
}
