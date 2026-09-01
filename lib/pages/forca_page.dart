import 'dart:math';

import 'package:jogo_da_forca/pages/historico_page.dart';
import 'package:flutter/material.dart';
import 'package:jogo_da_forca/widgets/letra_palavra_widget.dart';
import 'package:jogo_da_forca/widgets/teclado.dart';

enum StatusJogo {
  //Enums são usados para definir estados do jogo
  jogando,
  vitoria,
  derrota,
}

class ForcaPage extends StatefulWidget {
  //Stateful porque ele pode mudar de estado e atualizar ela.
  const ForcaPage({super.key});

  @override
  State<ForcaPage> createState() => _ForcaPageState();
}

class _ForcaPageState extends State<ForcaPage> {
  //Definindo as palavras que podem ser jogadas.
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

  late String
  palavraSorteada; //String como late para ser definida posteriormente.
  List<String> tentativas = []; //Lista de tentativas
  int perdas =
      0; //Contador de perdas, nao usamos vida para nao ter que ter outra variavel para mostrar na tela.
  List<String> historico =
      []; //Lista de histórico, eh enviada para tela de historico.
  bool salvouHistorico =
      false; //Flag para evitar salvar o mesmo histórico mais de uma vez
  bool mostrarTelaFinal = true; //Flag para mostrar a tela final

  @override
  void initState() {
    //Primeira funcao chamada, que inicia o jogo.
    super.initState();
    comecar();
  }

  StatusJogo get statusJogo {
    //Funcao que define o estado atual do jogo.
    if (perdas >= 5) {
      //Se o numero de perdas for maior ou igual a 5, o jogo acaba.
      return StatusJogo.derrota; //Define o status de derrota.
    }
    if (palavraSorteada
            .isNotEmpty && //Se a palavra sorteada nao estiver vazia e
        palavraSorteada
            .split('')
            .every((letra) => tentativas.contains(letra))) {
      //Cada letra da palavra estiver nas tentativas
      return StatusJogo.vitoria; //Define o status de vitoria
    }
    return StatusJogo.jogando; //Continua rodando o jogo
  }

  bool get acabou =>
      statusJogo != StatusJogo.jogando; //Funcao que define se o jogo acabou.

  void salvarHistorico() {
    //Aqui eh a logica de salvar o historico pra segunda tela.
    if (salvouHistorico == false) {
      //Se nao salvou o historico ainda
      if (statusJogo == StatusJogo.vitoria) {
        //Se ganhou
        historico.add(
          'Palavra: $palavraSorteada\nResultado: Vitória',
        ); //Adiciona o historico
      } else if (statusJogo == StatusJogo.derrota) {
        //Se perdeu
        historico.add(
          'Palavra: $palavraSorteada\nResultado: Derrota',
        ); //Adiciona o historico
      }

      salvouHistorico = true; //muda a flag para true
    }
  }

  void comecar() {
    //Funcao que inicia o jogo.
    setState(() {
      final random = Random(); //Gera um numero aleatorio
      palavraSorteada =
          palavras[random.nextInt(
            palavras.length,
          )]; //Escolhe uma palavra aleatoria com base no numero de antes.
      tentativas.clear(); //Limpa as tentativas.
      perdas = 0; //Zera as perdas.
      salvouHistorico = false; //Reinicia o historico.
      mostrarTelaFinal = true; //Reinicia a tela final.
    });
  }

  @override
  Widget build(BuildContext context) {
    //Widget que define o layout da tela.
    return Scaffold(
      extendBodyBehindAppBar:
          true, //Para o fundo do body que eh uma imagem pegar a appbar tambem usamos essa propriedade.
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        leading: IconButton(
          onPressed:
              comecar, //Botao de reiniciar a partida, chama a mesma funcao do comeco do jogo
          icon: Image.asset('assets/Reiniciar.png', width: 60, height: 60),
        ),
        title: SizedBox(
          height: 60,
          child: Image.asset('assets/titulo.png', fit: BoxFit.fitWidth),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, //Tira sombria, somente estetico

        actions: [
          IconButton(
            icon: Image.asset('assets/Historico.png', width: 60, height: 60),
            onPressed: () {
              Navigator.push(
                //Navigator push para ir para a tela de historico
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HistoricoPage(
                      historico: historico,
                    ); //Manda o historico para a tela de historico com o que ja preenchenmos antes.
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: Stack(
        //Stack é usado para sobrepor widgets, aqui usamos para sobrepor o body com a tela final.
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
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, //Funciona como um flexbox no CSS. Distribui os elementos igualmente no espaço restante.
              children: [
                SizedBox(height: 100),
                SizedBox(
                  height: 400,
                  child: Image.asset(
                    'assets/forca${perdas + 1}.png', //Carrega a imagem da forca baseada no numero de perdas. Os assets ja sao nomeados de acordo.
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .end, //Centraliza os elementos na parte de baixo.
                    children: [
                      const SizedBox(height: 40),
                      Wrap(
                        //Wrap funciona de maneira semelhante ao Flexbox, organizando os widgets filhos em uma linha e quebrando para a próxima se não houver espaço suficiente.
                        //melhor do que grid fixa.
                        alignment: WrapAlignment.center,
                        spacing: 0,
                        runSpacing: 0,
                        children: palavraSorteada.split('').map((letra) {
                          return LetraSorteadaWidget(
                            //Chama o widget das letras, aqui mesmo eh enviado se ele contem ou nao nas tentativas a palavra enviada, se ele tentou essa letra ele revela ela
                            //ou seja troca o asset, visivel no arquivo do widget.
                            letra: letra,
                            revelada: tentativas.contains(letra),
                          );
                        }).toList(), //Transforma a lista de letras em uma lista de widgets.
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Teclado(
                    //Aqui ele desenha o teclado, tambem todas as informacoes e logica sao controladas no forca_page, o telcado so recebe as informacoes
                    usadas: tentativas, //Envia a lista de tentativas
                    onLetra: (letra) {
                      //Funcao que eh chamada quando o usuario clica em uma letra
                      if (acabou) {
                        return; //Se o jogo acabou, nao faz nada evita que tenha cliques de depois do fim do jogo.
                      }

                      setState(() {
                        //Em todo esse bloco ele verifica se o usuario acertou ou errou a letra, soma perdas se errou, e verifica se o jogo acabou, se sim ele salva o historico.
                        tentativas.add(
                          letra,
                        ); // usa setstate justamente para buildar a tela denovo
                        if (!palavraSorteada.contains(letra)) {
                          perdas++;
                        }
                        if (acabou) {
                          salvarHistorico();
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (acabou &&
              mostrarTelaFinal) //Basicamente aqui ele valida se a pessoa ganhou ou perdeu e renderiza um asset de acordo com a condicao, por isso usa stack
            //outra abordagem seria usando o showDialog direto do flutter
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            mostrarTelaFinal = false;
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),

                      Expanded(
                        child: Image.asset(
                          statusJogo == StatusJogo.vitoria
                              ? 'assets/Ganhou.png'
                              : 'assets/perdeu.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
