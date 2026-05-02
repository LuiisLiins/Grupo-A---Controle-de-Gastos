import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final abas = [
  AbaItem(icon: Icons.home, label: 'Início'),
  AbaItem(icon: Icons.receipt_long, label: 'Histórico'),
  AbaItem(icon: Icons.bar_chart, label: 'Relatórios'),
  AbaItem(icon: Icons.person, label: 'Perfil'),
];

class AbaItem {
  final IconData icon;
  final String label;

  const AbaItem({
    required this.icon,
    required this.label,
  });
}

class BottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNav({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      child: SizedBox(
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(0),
            _item(1),
            const SizedBox(width: 40),
            _item(2),
            _item(3),
          ],
        ),
      ),
    );
  }

  Widget _item(int index) {
    final aba = abas[index];
    final ativo = navigationShell.currentIndex == index;

    return InkWell(
      onTap: () {
        navigationShell.goBranch(
          index,
          initialLocation:
              index == navigationShell.currentIndex,
        );
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              aba.icon,
              color: ativo
                  ? const Color(0xFF0F6FE8)
                  : Colors.grey,
            ),
            Text(
              aba.label,
              style: TextStyle(
                fontSize: 11,
                color: ativo
                    ? const Color(0xFF0F6FE8)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTransactionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTransactionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'mainFab',
      shape: const CircleBorder(),
      backgroundColor: const Color(0xFF0F6FE8),
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}