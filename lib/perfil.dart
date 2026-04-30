import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'models/usuario.dart';

class PerfilScreen extends StatefulWidget {
  final Usuario usuario;
  final bool showBackButton;
  final bool showBottomNavigationBar;

  const PerfilScreen({
    super.key,
    required this.usuario,
    this.showBackButton = true,
    this.showBottomNavigationBar = true,
  });

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String get _initial {
    final nome = widget.usuario.nome.trim();
    if (nome.isEmpty) return '?';
    return nome[0].toUpperCase();
  }

  void _voltar() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: widget.showBackButton
            ? IconButton(
                onPressed: _voltar,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              )
            : null,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE6ECF5)),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.blue,
                    child: Text(
                      _initial,
                      style: const TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.usuario.nome,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.usuario.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _item(Icons.person, 'Dados da Conta'),
            _item(Icons.lock, 'Segurança'),
            _item(Icons.notifications, 'Notificações'),
            _item(Icons.help, 'Ajuda'),
            _item(Icons.headset_mic, 'Suporte'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Sair da Conta'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icon, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                texto,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sair da Conta'),
        content: const Text('Deseja realmente sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}