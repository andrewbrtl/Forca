import 'package:flutter/material.dart';

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
    );
  }
}
