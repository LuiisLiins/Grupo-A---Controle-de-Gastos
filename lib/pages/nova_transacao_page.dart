import 'package:flutter/material.dart';

class NovaTransacaoPage extends StatelessWidget {
  const NovaTransacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Transação'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Tela Nova Transação'),
      ),
    );
  }
}