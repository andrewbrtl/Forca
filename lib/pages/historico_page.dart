import 'package:flutter/material.dart';

class HistoricoPage extends StatelessWidget {
  final List<String> historico;

  const HistoricoPage({
    super.key,
    required this.historico,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Histórico",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
      ),

      body: historico.isEmpty
          ? const Center(
              child: Text(
                "Não há histórico de partidas.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: historico.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  color: Colors.grey[200],
                  child: Text(
                    historico[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
    );
  }
}