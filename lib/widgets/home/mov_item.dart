import 'package:flutter/material.dart';

class MovItem extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String sub;
  final String valor;
  final Color cor;

  const MovItem({super.key, required this.icon, required this.titulo, required this.sub, required this.valor, required this.cor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(titulo),
      subtitle: Text(sub),
      trailing: Text(valor, style: TextStyle(color: cor, fontWeight: FontWeight.bold)),
    );
  }
}