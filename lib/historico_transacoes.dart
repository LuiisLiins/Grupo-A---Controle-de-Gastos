import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({
    super.key,
    this.showBackButton = true,
    this.showBottomNavigationBar = true,
  });

  final bool showBackButton;
  final bool showBottomNavigationBar;

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  static const Color _primaryBlue = Color(0xFF0F6FE8);
  static const Color _backgroundColor = Color(0xFFF5F7FB);
  static const Color _inactiveGray = Color(0xFF98A2B3);

  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Categoria';

  final List<_HistoricoGrupo> _grupos = const [
    _HistoricoGrupo(
      titulo: 'HOJE, 24 DE OUTUBRO',
      transacoes: [
        _HistoricoTransacao(
          corIcone: Color(0xFFFFE6D5),
          icone: Icons.shopping_cart_rounded,
          titulo: 'Supermercado Silva',
          subtitulo: 'Alimentação • 14:20',
          valor: '- R\$ 142,50',
          corValor: Color(0xFFE53935),
        ),
        _HistoricoTransacao(
          corIcone: Color(0xFFDDF0FF),
          icone: Icons.local_gas_station_rounded,
          titulo: 'Posto Ipiranga',
          subtitulo: 'Transporte • 09:15',
          valor: '- R\$ 250,00',
          corValor: Color(0xFFE53935),
        ),
      ],
    ),
    _HistoricoGrupo(
      titulo: 'ONTEM, 23 DE OUTUBRO',
      transacoes: [
        _HistoricoTransacao(
          corIcone: Color(0xFFDCFCE7),
          icone: Icons.account_balance_wallet_rounded,
          titulo: 'Salário Mensal',
          subtitulo: 'Renda • 18:00',
          valor: '+ R\$ 4.500,00',
          corValor: Color(0xFF16A34A),
        ),
        _HistoricoTransacao(
          corIcone: Color(0xFFF3E8FF),
          icone: Icons.movie_rounded,
          titulo: 'Netflix',
          subtitulo: 'Lazer • 10:30',
          valor: '- R\$ 55,90',
          corValor: Color(0xFFE53935),
        ),
      ],
    ),
    _HistoricoGrupo(
      titulo: '22 DE OUTUBRO',
      transacoes: [
        _HistoricoTransacao(
          corIcone: Color(0xFFFEF3C7),
          icone: Icons.flash_on_rounded,
          titulo: 'Conta de Luz',
          subtitulo: 'Contas • 16:45',
          valor: '- R\$ 189,32',
          corValor: Color(0xFFE53935),
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black87,
                ),
                onPressed: () => context.pop(),
              )
            : null,
        centerTitle: true,
        title: const Text(
          'Histórico',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE6ECF5)),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F6FE8), Color(0xFF4A9BFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x220F6FE8),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: _ResumoInfo(
                            label: 'Entradas',
                            value: 'R\$ 4.500,00',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _ResumoInfo(
                            label: 'Saídas',
                            value: 'R\$ 637,72',
                            alignEnd: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D101828),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search_rounded, color: _inactiveGray),
                        hintText: 'Pesquisar transações',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildFiltroBotao('Categoria'),
                      const SizedBox(width: 8),
                      _buildFiltroBotao('Tipo'),
                      const SizedBox(width: 8),
                      _buildFiltroBotao('Período'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  for (final grupo in _grupos) ...[
                    Text(
                      grupo.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _inactiveGray,
                        fontSize: 12,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (final transacao in grupo.transacoes)
                      _buildTransacaoCard(transacao),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomNavigationBar
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: 1,
              selectedItemColor: _primaryBlue,
              unselectedItemColor: _inactiveGray,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_rounded),
                  label: 'Histórico',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart_rounded),
                  label: 'Relatórios',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: 'Perfil',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildFiltroBotao(String texto) {
    final selecionado = _selectedFilter == texto;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = texto;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selecionado ? const Color(0xFFE8F1FF) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selecionado ? _primaryBlue : const Color(0xFFD7E2F0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
                style: TextStyle(
                  color: selecionado ? _primaryBlue : const Color(0xFF344054),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: selecionado ? _primaryBlue : const Color(0xFF344054),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransacaoCard(_HistoricoTransacao transacao) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: transacao.corIcone,
            child: Icon(transacao.icone, color: _primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transacao.titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transacao.subtitulo,
                  style: const TextStyle(
                    color: _inactiveGray,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            transacao.valor,
            style: TextStyle(
              color: transacao.corValor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResumoInfo extends StatelessWidget {
  const _ResumoInfo({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _HistoricoGrupo {
  const _HistoricoGrupo({required this.titulo, required this.transacoes});

  final String titulo;
  final List<_HistoricoTransacao> transacoes;
}

class _HistoricoTransacao {
  const _HistoricoTransacao({
    required this.corIcone,
    required this.icone,
    required this.titulo,
    required this.subtitulo,
    required this.valor,
    required this.corValor,
  });

  final Color corIcone;
  final IconData icone;
  final String titulo;
  final String subtitulo;
  final String valor;
  final Color corValor;
}