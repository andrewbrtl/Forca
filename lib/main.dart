import 'package:flutter/material.dart';
import 'package:jogo_da_forca/pages/forca_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forca',
      debugShowCheckedModeBanner: false,
      home: ForcaPage(),
    );
  }
}
