import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_nav.dart';

class AppLayout extends StatelessWidget {
  final Widget body;
  final StatefulNavigationShell navigationShell;

  const AppLayout({
    super.key,
    required this.body,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),

      body: body,

      floatingActionButton: AddTransactionButton(
        onPressed: () {
          context.push('/nova-transacao');
        },
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNav(
        navigationShell: navigationShell,
      ),
    );
  }
}