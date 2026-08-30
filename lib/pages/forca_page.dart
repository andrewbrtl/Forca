import 'dart:math';

import 'package:jogo_da_forca/pages/historico_page.dart';
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
  int perdas = 0;
  List<String> historico = [];

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
      perdas = 0;
    });
  }

  bool get perdeu => perdas >= 5;
  bool get ganhou =>
      palavraSorteada.split('').every((letra) => tentativas.contains(letra));
  bool get acabou => ganhou || perdeu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        leading: IconButton(
          onPressed: comecar,
          icon: Image.asset('assets/Reiniciar.png', width: 60, height: 60),
        ),
        title: SizedBox(
          height: 60,
          child: Image.asset('assets/titulo.png', fit: BoxFit.fitWidth),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

        actions: [
          IconButton(
            icon: Image.asset('assets/historico.png', width: 60, height: 60),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HistoricoPage(historico: historico);
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fundo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 100),
                SizedBox(
                  height: 400,
                  child: Image.asset(
                    'assets/forca${perdas + 1}.png',
                    fit: BoxFit.contain,
                  ),
                ),
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
                  child: Teclado(
                    usadas: tentativas,
                    onLetra: (letra) {
                      if (acabou) return;
                      setState(() {
                        tentativas.add(letra);
                        if (!palavraSorteada.contains(letra)) {
                          perdas++;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (acabou)
            Container(
              color: Colors.black.withValues(alpha: 0.6),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(
                    ganhou ? 'assets/ganhou.png' : 'assets/perdeu.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
