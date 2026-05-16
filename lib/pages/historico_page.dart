import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/transacao_provider.dart';
import '../models/enums.dart';
import '../models/gasto.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TransacaoProvider>();
    final agrupadas = prov.agrupadasPorData;
    final chaves = agrupadas.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar transação...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (v) => prov.configurarFiltros(busca: v),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(
                  label: prov.tipoSelecionado,
                  icon: Icons.filter_list,
                  onTap: () => _modalTipo(context, prov),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Período',
                  icon: Icons.calendar_today,
                  onTap: () => _modalData(context, prov),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: prov.ordenarPor == "data" ? "Data ↓" : "Valor ↓",
                  icon: Icons.sort,
                  onTap: () => _modalOrdem(context, prov),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: prov.filtradas.isEmpty
                ? _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: chaves.length,
                    itemBuilder: (context, i) {
                      final dataKey = chaves[i];
                      final lista = agrupadas[dataKey]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
                            child: Text(dataKey, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                          ),
                          ...lista.map((t) => _TransactionTile(transaction: t)),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _modalTipo(BuildContext context, TransacaoProvider prov) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ['Todos', 'Receita', 'Despesa'].map((tipo) => ListTile(
          title: Text(tipo),
          trailing: prov.tipoSelecionado == tipo ? const Icon(Icons.check, color: Colors.blue) : null,
          onTap: () {
            prov.configurarFiltros(tipo: tipo);
            Navigator.pop(context);
          },
        )).toList(),
      ),
    );
  }

  void _modalData(BuildContext context, TransacaoProvider prov) async {
    final pick = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: prov.dataInicio, end: prov.dataFim),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pick != null) prov.configurarFiltros(inicio: pick.start, fim: pick.end);
  }

  void _modalOrdem(BuildContext context, TransacaoProvider prov) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Data'),
            onTap: () { prov.configurarFiltros(ordem: 'data'); Navigator.pop(context); },
          ),
          ListTile(
            title: const Text('Valor'),
            onTap: () { prov.configurarFiltros(ordem: 'valor'); Navigator.pop(context); },
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Gasto transaction;
  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isReceita = transaction.tipo == TipoTransacao.receita;
    final cor = isReceita ? const Color(0xFF34C759) : const Color(0xFFFF3B30);

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => context.read<TransacaoProvider>().removerTransacao(transaction.id),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Excluir',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: cor.withOpacity(0.1),
            child: Icon(isReceita ? Icons.arrow_downward : Icons.arrow_upward, color: cor),
          ),
          title: Text(transaction.descricao, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text("${transaction.data.hour}:${transaction.data.minute}", style: const TextStyle(fontSize: 12)),
          trailing: Text(
            "${isReceita ? '+' : '-'} R\$ ${transaction.valor.toStringAsFixed(2)}",
            style: TextStyle(fontWeight: FontWeight.bold, color: cor),
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 64, color: Colors.grey[300]),
          const Text('Nenhuma transação encontrada', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}