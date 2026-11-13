import 'package:flutter/material.dart';
import 'curriculo_api.dart';
import 'screens/tela_curriculo.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final api = const CurriculoApi('http://10.0.2.2:3000');

  String nome = '';
  String email = '';
  String telefone = '';

  @override void initState() {
    super.initState();
    carregarCurriculo();
  }

  Future<void> carregarCurriculo() async {
    try {
      final dados = await api.buscarCurriculo(1);
      setState(() {
        nome = dados['nome'] ?? '';
        email = dados['email'] ?? '';
        telefone = dados['telefone'] ?? '';
      });

    } catch (erro) {
      debugPrint('Erro: $erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CurriculoPage(),
    );
  }
}