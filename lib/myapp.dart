import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gestaodegastos/perfil.dart';

import 'historico_transacoes.dart';
import 'models/usuario.dart';
import 'myhomepage.dart';
import 'transacao.dart';

// Defina as rotas como constantes para evitar erros de digitação
class AppRoutes {
  static const home = '/';
  static const historico = '/historico';
  static const relatorios = '/relatorios';
  static const perfil = '/perfil';
  static const transacao = '/transacao';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
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

  // Configuração do GoRouter
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: AppRoutes.home,  // Rota inicial
      routes: [
        // Rota da página inicial com shell para BottomNavigationBar
        ShellRoute(
          builder: (context, state, child) => _MainScaffold(child: child),
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => MyHomePage(
                title: 'Página Inicial',
                onOpenHistorico: () => context.go(AppRoutes.historico),
                onOpenRelatorios: () => context.go(AppRoutes.relatorios),
                onOpenPerfil: () => context.go(AppRoutes.perfil),
                onAddTransaction: () => context.go(AppRoutes.transacao),
              ),
            ),
            GoRoute(
              path: AppRoutes.historico,
              builder: (context, state) => const HistoricoPage(
                showBackButton: true,
                showBottomNavigationBar: false,
              ),
            ),
            GoRoute(
              path: AppRoutes.relatorios,
              builder: (context, state) => const _ReportsPlaceholder(),
            ),
            GoRoute(
              path: AppRoutes.perfil,
              builder: (context, state) => PerfilScreen(
                usuario: _usuarioMock,
                showBackButton: true,
                showBottomNavigationBar: false,
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.transacao,
          builder: (context, state) => const TransacaoScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Controle de Gastos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _primaryBlue),
      ),
    );
  }
}

class _MainScaffold extends StatefulWidget {
  const _MainScaffold({required this.child});

  final Widget child;

  @override
  State<_MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<_MainScaffold> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.historico);
        break;
      case 2:
        context.go(AppRoutes.relatorios);
        break;
      case 3:
        context.go(AppRoutes.perfil);
        break;
    }
  }

  void _openTransactionScreen() {
    context.go(AppRoutes.transacao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _MyAppState._primaryBlue.withValues(alpha: 0.28),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _openTransactionScreen,
          backgroundColor: _MyAppState._primaryBlue,
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 34, color: Colors.white),
        ),
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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

class _ReportsPlaceholder extends StatelessWidget {
  const _ReportsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D101828),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bar_chart_rounded,
                    size: 48,
                    color: _MyAppState._primaryBlue,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Relatórios em breve',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Esta área seguirá o mesmo layout principal do aplicativo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF667085)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
