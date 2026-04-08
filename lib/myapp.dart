import 'package:flutter/material.dart';
import 'package:gestaodegastos/perfil.dart';

import 'models/usuario.dart';
import 'myhomepage.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const Color _primaryBlue = Color(0xFF0F6FE8);
  static const Color _inactiveGray = Color(0xFF98A2B3);
  static final Usuario _usuarioMock = Usuario(
    id: 1,
    nome: 'Bruno Silva',
    email: 'bruno@email.com',
    telefone: '(11) 99999-9999',
    criadoEm: DateTime(2024, 1, 1),
  );

  int _currentIndex = 0; // Índice da tela atual

  // List of pages to navigate
  List<Widget> get _pages => [
    const MyHomePage(title: 'Página Inicial'),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    PerfilScreen(
      usuario: _usuarioMock,
      showBackButton: false,
      showBottomNavigationBar: false,
    ),
  ];

  // Função para alternar as telas
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Atualiza o índice da tela selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _primaryBlue),
      ),
      home: Scaffold(
        extendBody: true,
        body: _pages[_currentIndex], // Exibe a tela baseada no índice
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _primaryBlue.withValues(alpha: 0.28),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: _primaryBlue,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: 34, color: Colors.white),
          ),
        ),
        bottomNavigationBar: _BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE6ECF5))),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 88,
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Início',
                  selected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.receipt_long_rounded,
                  label: 'Histórico',
                  selected: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
              ),
              const SizedBox(width: 84),
              Expanded(
                child: _NavItem(
                  icon: Icons.bar_chart_rounded,
                  label: 'Relatórios',
                  selected: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Perfil',
                  selected: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? _MyAppState._primaryBlue
        : _MyAppState._inactiveGray;
    final fontWeight = selected ? FontWeight.w700 : FontWeight.w500;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
