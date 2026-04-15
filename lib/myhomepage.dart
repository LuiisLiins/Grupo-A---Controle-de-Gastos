import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.onOpenHistorico,
    this.onOpenRelatorios,
    this.onOpenPerfil,
    this.onAddTransaction,
  });

  static const Color _primaryBlue = Color(0xFF0F6FE8);

  final String title;
  final VoidCallback? onOpenHistorico;
  final VoidCallback? onOpenRelatorios;
  final VoidCallback? onOpenPerfil;
  final VoidCallback? onAddTransaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF667085),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Controle financeiro',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Color(0xFFE8F1FF),
              child: Icon(Icons.notifications_none_rounded, color: _primaryBlue),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE6ECF5)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F6FE8), Color(0xFF4A9BFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x220F6FE8),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo do mês',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'R\$ 3.862,28',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Acompanhe receitas, despesas e acessos rápidos às telas principais.',
                    style: TextStyle(color: Colors.white, height: 1.3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Acessos rápidos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101828),
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _QuickAccessCard(
                  icon: Icons.receipt_long_rounded,
                  label: 'Ver histórico',
                  subtitle: 'Consulte transações',
                  onTap: onOpenHistorico,
                ),
                _QuickAccessCard(
                  icon: Icons.add_circle_outline_rounded,
                  label: 'Nova transação',
                  subtitle: 'Cadastre receita ou despesa',
                  onTap: onAddTransaction,
                ),
                _QuickAccessCard(
                  icon: Icons.bar_chart_rounded,
                  label: 'Relatórios',
                  subtitle: 'Analise seus gastos',
                  onTap: onOpenRelatorios,
                ),
                _QuickAccessCard(
                  icon: Icons.person_outline_rounded,
                  label: 'Meu perfil',
                  subtitle: 'Veja seus dados',
                  onTap: onOpenPerfil,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D101828),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo rápido',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• 12 movimentações cadastradas esta semana\n'
                    '• Maior gasto: Transporte\n'
                    '• Meta mensal: 78% concluída',
                    style: TextStyle(color: Color(0xFF667085), height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D101828),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: MyHomePage._primaryBlue),
              ),
              const Spacer(),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF667085),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
