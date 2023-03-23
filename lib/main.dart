import 'package:flutter/material.dart';
import 'package:variacaopreco_app/pages/home/inicio_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Variação de preço',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Inicio(),
    );
  }
}
