import 'package:flutter/material.dart';
import 'package:jogo_da_forca/widgets/teclado.dart';

class ForcaPage extends StatefulWidget {
  const ForcaPage({super.key});

  @override
  State<ForcaPage> createState() => _ForcaPageState();
}

class _ForcaPageState extends State<ForcaPage> {
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
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: const Center(
                child: Text("area de ciima", style: TextStyle(fontSize: 24)),
              ),
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
