import 'package:flutter/material.dart';

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
    if (nome.isEmpty) {
      return '?';
    }
    return nome[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 4),
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.orange[200],
                          child: Text(
                            _initial,
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 5,
                        right: 5,
                        child: _EditAvatarButton(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.usuario.nome,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.usuario.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'MEMBRO PREMIUM',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.card_membership,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Meu Plano',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Plano Anual - Expira em 12/2024',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GERAL',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItemGeneral(
                    icon: Icons.person,
                    label: 'Dados da Conta',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItemGeneral(
                    icon: Icons.security,
                    label: 'Segurança e Biometria',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItemGeneral(
                    icon: Icons.notifications,
                    label: 'Notificações',
                    badge: '3',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OUTROS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItemGeneral(
                    icon: Icons.headset_mic,
                    label: 'Suporte',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItemGeneral(
                    icon: Icons.help,
                    label: 'FAQ',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  _showLogoutDialog(context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red, size: 24),
                    SizedBox(width: 16),
                    Text(
                      'Sair da Conta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'FINANÇAS PRO VERSION 2.4.0',
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomNavigationBar
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: 3,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Extrato',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up),
                  label: 'Investir',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildMenuItemGeneral({
    required IconData icon,
    required String label,
    String? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.blue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 18),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sair da Conta'),
          content: const Text('Tem certeza que deseja sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sair', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class _EditAvatarButton extends StatelessWidget {
  const _EditAvatarButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.edit, color: Colors.white, size: 24),
    );
  }
}
