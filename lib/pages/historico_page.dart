import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/gasto.dart';
import '../models/enums.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  // Lista mockada de transações para exemplo
  late List<Gasto> transactions;
  late List<Gasto> filteredTransactions;

  // Filtros
  String searchQuery = "";
  String selectedType = "Todos";
  String selectedCategory = "Todos";
  late DateTime startDate;
  late DateTime endDate;
  String sortBy = "data"; // "data" ou "valor"
  bool sortAscending = false;

  final categoriasDespesa = [
    'Alimentação',
    'Transporte',
    'Moradia',
    'Lazer',
    'Saúde',
  ];

  final categoriasReceita = [
    'Salário',
    'Freelance',
    'Extra',
    'Investimento',
  ];

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now().subtract(const Duration(days: 90));
    endDate = DateTime.now();
    _initializeTransactions();
    _applyFilters();
  }

  void _initializeTransactions() {
    // Dados mockados para exemplo
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
        descricao: 'Salário',
        valor: 4500.00,
        data: DateTime.now().subtract(const Duration(days: 1)),
        categoriaId: 1,
        usuarioId: 1,
        tipo: TipoTransacao.receita,
      ),
      Gasto(
        id: 4,
        descricao: 'Cinema',
        valor: 50.00,
        data: DateTime.now().subtract(const Duration(days: 2)),
        categoriaId: 4,
        usuarioId: 1,
        tipo: TipoTransacao.despesa,
      ),
      Gasto(
        id: 5,
        descricao: 'Freelance',
        valor: 250.00,
        data: DateTime.now().subtract(const Duration(days: 3)),
        categoriaId: 2,
        usuarioId: 1,
        tipo: TipoTransacao.receita,
      ),
    ];
  }

  void _applyFilters() {
    filteredTransactions = transactions.where((transaction) {
      // Filtro por data
      if (transaction.data.isBefore(startDate) ||
          transaction.data.isAfter(endDate.add(const Duration(days: 1)))) {
        return false;
      }

      // Filtro por tipo
      if (selectedType != "Todos") {
        final tipo =
            selectedType == "Receita"
                ? TipoTransacao.receita
                : TipoTransacao.despesa;
        if (transaction.tipo != tipo) {
          return false;
        }
      }

      // Filtro por categoria
      if (selectedCategory != "Todos") {
        if (transaction.categoriaId != _getCategoryId(selectedCategory)) {
          return false;
        }
      }

      // Filtro por pesquisa
      if (searchQuery.isNotEmpty) {
        if (!transaction.descricao
            .toLowerCase()
            .contains(searchQuery.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();

    // Aplicar ordenação
    if (sortBy == "data") {
      filteredTransactions.sort((a, b) {
        final compare = b.data.compareTo(a.data);
        return sortAscending ? -compare : compare;
      });
    } else if (sortBy == "valor") {
      filteredTransactions.sort((a, b) {
        final compare = a.valor.compareTo(b.valor);
        return sortAscending ? compare : -compare;
      });
    }
  }

  int _getCategoryId(String categoryName) {
    if (categoriasDespesa.contains(categoryName)) {
      return categoriasDespesa.indexOf(categoryName) + 1;
    }
    return categoriasReceita.indexOf(categoryName) + 1;
  }

  Map<String, List<Gasto>> _groupByDate() {
    final grouped = <String, List<Gasto>>{};

    for (final transaction in filteredTransactions) {
      final now = DateTime.now();
      final today =
          DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final transactionDate =
          DateTime(transaction.data.year, transaction.data.month, transaction.data.day);

      late String key;
      if (transactionDate == today) {
        key = "Hoje";
      } else if (transactionDate == yesterday) {
        key = "Ontem";
      } else {
        key =
            "${transactionDate.day.toString().padLeft(2, '0')}/${transactionDate.month.toString().padLeft(2, '0')}/${transactionDate.year}";
      }

      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(transaction);
    }

    return grouped;
  }

  void _showDeleteDialog(Gasto transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir transação?'),
        content: Text('Deseja excluir "${transaction.descricao}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                transactions.removeWhere((t) => t.id == transaction.id);
                _applyFilters();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transação excluída')),
              );
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailDialog(Gasto transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(transaction.descricao),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Valor: R\$ ${transaction.valor.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Data: ${transaction.data.day}/${transaction.data.month}/${transaction.data.year}',
            ),
            const SizedBox(height: 8),
            Text(
              'Tipo: ${transaction.tipo == TipoTransacao.receita ? 'Receita' : 'Despesa'}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar edição
            },
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar transação...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _applyFilters();
                });
              },
            ),
          ),
          // Filtros
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Filtro por tipo
                _buildFilterChip(
                  label: selectedType,
                  onTap: () => _showTypeFilter(),
                  icon: Icons.filter_list,
                ),
                const SizedBox(width: 8),
                // Filtro por categoria
                _buildFilterChip(
                  label: selectedCategory,
                  onTap: () => _showCategoryFilter(),
                  icon: Icons.category,
                ),
                const SizedBox(width: 8),
                // Filtro por período
                _buildFilterChip(
                  label: 'Período',
                  onTap: () => _showDateRangeFilter(),
                  icon: Icons.calendar_today,
                ),
                const SizedBox(width: 8),
                // Ordenação
                _buildFilterChip(
                  label: sortBy == "data" ? "Data ↓" : "Valor ↓",
                  onTap: () => _showSortFilter(),
                  icon: Icons.sort,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Lista de transações
          Expanded(
            child: filteredTransactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhuma transação encontrada',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildTransactionList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF0F6FE8)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    final grouped = _groupByDate();
    final groupedKeys = grouped.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: groupedKeys.length,
      itemBuilder: (context, dateIndex) {
        final dateKey = groupedKeys[dateIndex];
        final dayTransactions = grouped[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 8,
                left: 4,
              ),
              child: Text(
                dateKey,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            ...dayTransactions.map((transaction) {
              final isReceita = transaction.tipo == TipoTransacao.receita;
              final cor = isReceita
                  ? const Color(0xFF34C759)
                  : const Color(0xFFFF3B30);

              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // TODO: Implementar edição
                      },
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Editar',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        _showDeleteDialog(transaction);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Excluir',
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => _showDetailDialog(transaction),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: cor.withOpacity(0.1),
                        child: Icon(
                          isReceita
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: cor,
                        ),
                      ),
                      title: Text(
                        transaction.descricao,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '${transaction.data.hour.toString().padLeft(2, '0')}:${transaction.data.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Text(
                        '${isReceita ? '+' : '-'} R\$ ${transaction.valor.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  void _showTypeFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Filtrar por Tipo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...[
            'Todos',
            'Receita',
            'Despesa',
          ].map(
            (type) => ListTile(
              title: Text(type),
              trailing: selectedType == type
                  ? const Icon(Icons.check, color: Color(0xFF0F6FE8))
                  : null,
              onTap: () {
                setState(() {
                  selectedType = type;
                  _applyFilters();
                });
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Filtrar por Categoria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...[
            'Todos',
            ...categoriasDespesa,
            ...categoriasReceita,
          ]
              .toSet()
              .toList()
              .map(
                (category) => ListTile(
                  title: Text(category),
                  trailing: selectedCategory == category
                      ? const Icon(Icons.check, color: Color(0xFF0F6FE8))
                      : null,
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                      _applyFilters();
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
        ],
      ),
    );
  }

  void _showDateRangeFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Selecionar Período',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Data Inicial'),
              subtitle: Text(
                '${startDate.day}/${startDate.month}/${startDate.year}',
              ),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    startDate = picked;
                    _applyFilters();
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Data Final'),
              subtitle: Text(
                '${endDate.day}/${endDate.month}/${endDate.year}',
              ),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: endDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    endDate = picked;
                    _applyFilters();
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Ordenar por',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Data'),
            trailing: sortBy == "data"
                ? const Icon(Icons.check, color: Color(0xFF0F6FE8))
                : null,
            onTap: () {
              setState(() {
                sortBy = "data";
                _applyFilters();
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Valor'),
            trailing: sortBy == "valor"
                ? const Icon(Icons.check, color: Color(0xFF0F6FE8))
                : null,
            onTap: () {
              setState(() {
                sortBy = "valor";
                _applyFilters();
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              sortAscending ? 'Crescente ↑' : 'Decrescente ↓',
            ),
            onTap: () {
              setState(() {
                sortAscending = !sortAscending;
                _applyFilters();
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
