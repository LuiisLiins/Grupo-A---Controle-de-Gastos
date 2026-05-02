import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authService.login();
          },
          child: const Text('Entrar'),
        ),
      ),
    );
  }
}