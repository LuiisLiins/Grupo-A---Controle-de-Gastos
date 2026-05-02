import 'package:flutter/material.dart';
import 'package:gestaodegastos/routes/app_routes.dart';

void main() {
  runApp(const GestaoGastosApp());
}

class GestaoGastosApp extends StatelessWidget {
  const GestaoGastosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gestão de Gastos',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F6FE8),
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}