import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/transacao_provider.dart';
import '../models/gasto.dart';
import '../models/enums.dart';

class RelatoriosPage extends StatelessWidget {
  const RelatoriosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TransacaoProvider>();
    final filtradas = prov.filtradas;

    final totalReceita = filtradas
        .where((t) => t.tipo == TipoTransacao.receita)
        .fold(0.0, (sum, t) => sum + t.valor);

    final totalDespesa = filtradas
        .where((t) => t.tipo == TipoTransacao.despesa)
        .fold(0.0, (sum, t) => sum + t.valor);

    final saldo = totalReceita - totalDespesa;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Relatórios'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(context, prov),
            const SizedBox(height: 24),
            _buildSummaryCards(totalReceita, totalDespesa, saldo),
            const SizedBox(height: 24),
            _buildInsightsSection(totalReceita, totalDespesa),
            const SizedBox(height: 24),
            _buildCategoryPieChart(filtradas),
            const SizedBox(height: 24),
            _buildIncomeVsExpenseChart(totalReceita, totalDespesa),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context, TransacaoProvider prov) {
    return Row(
      children: [
        Expanded(
          child: _DateTile(
            label: 'Início',
            date: prov.dataInicio,
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: prov.dataInicio,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (d != null) prov.configurarFiltros(inicio: d);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _DateTile(
            label: 'Fim',
            date: prov.dataFim,
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: prov.dataFim,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (d != null) prov.configurarFiltros(fim: d);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(double rec, double des, double bal) {
    return Column(
      children: [
        Row(
          children: [
            _SummaryCard(label: 'Receita', value: rec, color: Colors.green),
            const SizedBox(width: 12),
            _SummaryCard(label: 'Despesa', value: des, color: Colors.red),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bal >= 0 ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo', style: TextStyle(color: Colors.white)),
              Text('R\$ ${bal.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightsSection(double rec, double des) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Insights', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _InsightTile(text: 'Sua economia atual é de R\$ ${(rec - des).toStringAsFixed(2)}'),
        if (rec > 0 && des > rec * 0.8)
          const _InsightTile(text: 'Alerta! Suas despesas superam 80% da renda.', isAlert: true),
      ],
    );
  }

  Widget _buildCategoryPieChart(List<Gasto> lista) {
    final map = <String, double>{};
    for (var t in lista.where((t) => t.tipo == TipoTransacao.despesa)) {
      map[t.categoriaId.toString()] = (map[t.categoriaId.toString()] ?? 0) + t.valor;
    }
    if (map.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Despesas por Categoria', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: PieChart(PieChartData(sections: map.entries.map((e) {
            return PieChartSectionData(value: e.value, title: 'R\$ ${e.value.toStringAsFixed(0)}', radius: 50, color: Colors.blue);
          }).toList())),
        ),
      ],
    );
  }

  Widget _buildIncomeVsExpenseChart(double rec, double des) {
    return SizedBox(
      height: 200,
      child: BarChart(BarChartData(barGroups: [
        BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: rec, color: Colors.green, width: 20)]),
        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: des, color: Colors.red, width: 20)]),
      ])),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;
  const _DateTile({required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text('${date.day}/${date.month}/${date.year}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _SummaryCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text('R\$ ${value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  final String text;
  final bool isAlert;
  const _InsightTile({required this.text, this.isAlert = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAlert ? Colors.red.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb, color: isAlert ? Colors.red : Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}