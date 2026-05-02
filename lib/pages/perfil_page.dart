import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          authService.logout();
        },
        child: const Text('Sair'),
      ),
    );
  }
}