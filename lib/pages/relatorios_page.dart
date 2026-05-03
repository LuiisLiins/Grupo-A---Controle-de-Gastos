import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/gasto.dart';
import '../models/enums.dart';

class RelatoriosPage extends StatefulWidget {
  const RelatoriosPage({super.key});

  @override
  State<RelatoriosPage> createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  late List<Gasto> transactions;
  late DateTime startDate;
  late DateTime endDate;

  final categoriasDespesa = [
    'Alimentação',
    'Transporte',
    'Moradia',
    'Lazer',
    'Saúde',
  ];

  final categoriasReceita = ['Salário', 'Freelance', 'Extra', 'Investimento'];

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now().subtract(const Duration(days: 90));
    endDate = DateTime.now();
    _initializeTransactions();
  }

  void _initializeTransactions() {
    transactions = [
      Gasto(
        id: 1,
        descricao: 'Mercado',
        valor: 80.00,
        data: DateTime.now(),
        categoriaId: 1,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 2,
        descricao: 'Uber',
        valor: 22.00,
        data: DateTime.now(),
        categoriaId: 2,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 3,
        descricao: 'Aluguel',
        valor: 1200.00,
        data: DateTime.now().subtract(const Duration(days: 1)),
        categoriaId: 3,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 4,
        descricao: 'Salário',
        valor: 4500.00,
        data: DateTime.now().subtract(const Duration(days: 1)),
        categoriaId: 1,
        usuarioId: 1,
        tipo: TipoTransacao.receita,
      ),
      Gasto(
        id: 5,
        descricao: 'Cinema',
        valor: 50.00,
        data: DateTime.now().subtract(const Duration(days: 2)),
        categoriaId: 4,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 6,
        descricao: 'Farmácia',
        valor: 120.00,
        data: DateTime.now().subtract(const Duration(days: 5)),
        categoriaId: 5,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 7,
        descricao: 'Freelance',
        valor: 250.00,
        data: DateTime.now().subtract(const Duration(days: 3)),
        categoriaId: 2,
        usuarioId: 1,
        tipo: TipoTransacao.receita,
      ),
      Gasto(
        id: 8,
        descricao: 'Restaurante',
        valor: 85.00,
        data: DateTime.now().subtract(const Duration(days: 7)),
        categoriaId: 1,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 9,
        descricao: 'Uber',
        valor: 18.00,
        data: DateTime.now().subtract(const Duration(days: 10)),
        categoriaId: 2,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 10,
        descricao: 'Salário',
        valor: 4500.00,
        data: DateTime.now().subtract(const Duration(days: 30)),
        categoriaId: 1,
        usuarioId: 1,
        tipo: TipoTransacao.receita,
      ),
    ];
  }

  List<Gasto> _getFilteredTransactions() {
    return transactions.where((t) {
      return !t.data.isBefore(startDate) &&
          !t.data.isAfter(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  Map<String, double> _getCategoryExpenses() {
    final filtered = _getFilteredTransactions();
    final expenses = <String, double>{};

    for (final gasto in filtered) {
      if (gasto.tipo == TipoTransacao.despesa) {
        final categoryName = _getCategoryName(gasto.categoriaId);
        expenses[categoryName] = (expenses[categoryName] ?? 0) + gasto.valor;
      }
    }

    return expenses;
  }

  String _getCategoryName(int categoryId) {
    if (categoryId <= categoriasDespesa.length) {
      return categoriasDespesa[categoryId - 1];
    }
    return categoriasReceita[categoryId - 1];
  }

  Map<int, double> _getMonthlyExpenses() {
    final filtered = _getFilteredTransactions();
    final monthly = <int, double>{};

    for (final gasto in filtered) {
      final monthKey = gasto.data.month;
      monthly[monthKey] = (monthly[monthKey] ?? 0) + gasto.valor;
    }

    return monthly;
  }

  double _getTotalExpenses() {
    return _getFilteredTransactions()
        .where((t) => t.tipo == TipoTransacao.despesa)
        .fold(0, (sum, t) => sum + t.valor);
  }

  double _getTotalIncome() {
    return _getFilteredTransactions()
        .where((t) => t.tipo == TipoTransacao.receita)
        .fold(0, (sum, t) => sum + t.valor);
  }

  double _getAverageDailyExpense() {
    final filtered = _getFilteredTransactions();
    if (filtered.isEmpty) return 0;

    final total = _getTotalExpenses();
    final days = filtered.length > 0
        ? endDate.difference(startDate).inDays + 1
        : 1;

    return total / days;
  }

  String _getMostExpensiveCategory() {
    final expenses = _getCategoryExpenses();
    if (expenses.isEmpty) return 'N/A';

    final topCategory = expenses.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );
    return topCategory.key;
  }

  List<String> _generateInsights() {
    final insights = <String>[];
    final totalExpense = _getTotalExpenses();
    final totalIncome = _getTotalIncome();
    final avgDaily = _getAverageDailyExpense();

    final balance = totalIncome - totalExpense;
    if (balance > 0) {
      final percentage = ((balance / totalIncome) * 100).toStringAsFixed(0);
      insights.add('Economia acumulada: R\$ ${balance.toStringAsFixed(2)}');
    }

    insights.add('Gasto médio diário: R\$ ${avgDaily.toStringAsFixed(2)}');

    final despesaPercentage = totalIncome > 0
        ? ((totalExpense / totalIncome) * 100).toStringAsFixed(0)
        : '0';
    if (int.parse(despesaPercentage) > 80) {
      insights.add('Alerta! Você gastou ${despesaPercentage}% da sua renda');
    }

    insights.add('Categoria com mais gastos: ${_getMostExpensiveCategory()}');

    return insights;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet =
        MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Relatórios'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            const SizedBox(height: 24),

            _buildSummaryCards(),
            const SizedBox(height: 24),

            _buildInsightsSection(),
            const SizedBox(height: 24),

            _buildCategoryPieChart(),
            const SizedBox(height: 24),

            _buildIncomeVsExpenseChart(),
            const SizedBox(height: 24),

            _buildMonthlyBarChart(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Período',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => startDate = picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Início',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${startDate.day}/${startDate.month}/${startDate.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => endDate = picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fim',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${endDate.day}/${endDate.month}/${endDate.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    final totalIncome = _getTotalIncome();
    final totalExpense = _getTotalExpenses();
    final balance = totalIncome - totalExpense;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Receita',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'R\$ ${totalIncome.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF34C759),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Despesa',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'R\$ ${totalExpense.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF3B30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          color: balance >= 0
              ? const Color(0xFF34C759)
              : const Color(0xFFFF3B30),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saldo',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  '${balance >= 0 ? '+' : ''} R\$ ${balance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInsightsSection() {
    final insights = _generateInsights();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Insights',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...insights.map((insight) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      insight,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCategoryPieChart() {
    final categoryExpenses = _getCategoryExpenses();
    if (categoryExpenses.isEmpty) {
      return const Center(child: Text('Sem dados para o período'));
    }

    final total = categoryExpenses.values.fold(0.0, (sum, val) => sum + val);
    final colors = [
      const Color(0xFF0F6FE8),
      const Color(0xFF34C759),
      const Color(0xFFFF9500),
      const Color(0xFFFF3B30),
      const Color(0xFFAF52DE),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gastos por Categoria',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      sections: categoryExpenses.entries
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            final value = item.value;
                            final percentage = (value / total * 100);

                            return PieChartSectionData(
                              value: value,
                              color: colors[index % colors.length],
                              title: '${percentage.toStringAsFixed(0)}%',
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Legenda
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categoryExpenses.entries
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: colors[index % colors.length],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.key,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              Text(
                                'R\$ ${item.value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeVsExpenseChart() {
    final totalIncome = _getTotalIncome();
    final totalExpense = _getTotalExpenses();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Receita vs Despesa',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: totalIncome,
                          color: const Color(0xFF34C759),
                          width: 30,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: totalExpense,
                          color: const Color(0xFFFF3B30),
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text(
                                'Receita',
                                style: TextStyle(fontSize: 12),
                              );
                            case 1:
                              return const Text(
                                'Despesa',
                                style: TextStyle(fontSize: 12),
                              );
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            'R\$ ${(value / 1000).toStringAsFixed(0)}k',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyBarChart() {
    final monthlyExpenses = _getMonthlyExpenses();
    if (monthlyExpenses.isEmpty) {
      return const Center(child: Text('Sem dados para o período'));
    }

    final monthNames = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Evolução Financeira (Últimos Meses)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: monthlyExpenses.entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value,
                              color: const Color(0xFF0F6FE8),
                              width: 20,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final monthIndex = value.toInt() - 1;
                          if (monthIndex >= 0 &&
                              monthIndex < monthNames.length) {
                            return Text(
                              monthNames[monthIndex],
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            'R\$ ${(value / 1000).toStringAsFixed(0)}k',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
