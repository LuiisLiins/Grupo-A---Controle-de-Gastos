import 'package:flutter/material.dart';

class TransacaoScreen extends StatefulWidget {
  const TransacaoScreen({super.key});

  @override
  State<TransacaoScreen> createState() => _TransacaoScreenState();
}

class _TransacaoScreenState extends State<TransacaoScreen> {
  static const Color _primaryBlue = Color(0xFF0F6FE8);
  static const Color _backgroundColor = Color(0xFFF5F7FB);

  String _tipoTransacao = 'Despesa';
  String _categoriaSelecionada = 'Comida';
  DateTime _dataSelecionada = DateTime.now();

  final TextEditingController _valorController = TextEditingController(
    text: '0,00',
  );
  final TextEditingController _descricaoController = TextEditingController();

  final List<Map<String, dynamic>> _categorias = const [
    {'label': 'Comida', 'icon': Icons.restaurant_rounded},
    {'label': 'Transporte', 'icon': Icons.directions_car_rounded},
    {'label': 'Lazer', 'icon': Icons.sports_esports_rounded},
    {'label': 'Saúde', 'icon': Icons.favorite_outline_rounded},
    {'label': 'Compras', 'icon': Icons.shopping_bag_outlined},
    {'label': 'Outro', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  void dispose() {
    _valorController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Adicionar transação',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE6ECF5)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              child: Column(
                children: [
                  const Text(
                    'Informe o valor',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _valorController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      prefixText: 'R\$ ',
                      prefixStyle: TextStyle(
                        color: _primaryBlue,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: 'Tipo',
              child: Row(
                children: [
                  Expanded(child: _buildTipoBotao('Despesa')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTipoBotao('Receita')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: 'Categoria',
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.05,
                ),
                itemCount: _categorias.length,
                itemBuilder: (context, index) {
                  final categoria = _categorias[index];
                  final isSelected =
                      _categoriaSelecionada == categoria['label'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _categoriaSelecionada = categoria['label'] as String;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: isSelected
                            ? const Color(0xFFE8F1FF)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? _primaryBlue
                              : const Color(0xFFD7E2F0),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categoria['icon'] as IconData,
                            color: isSelected
                                ? _primaryBlue
                                : const Color(0xFF667085),
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            categoria['label'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? _primaryBlue
                                  : const Color(0xFF344054),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: 'Data',
              child: InkWell(
                onTap: _selecionarData,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD7E2F0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: _primaryBlue,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _formatarData(_dataSelecionada),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF98A2B3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: 'Descrição',
              child: TextField(
                controller: _descricaoController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Descreva a movimentação',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _salvarTransacao,
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: Text(
                  _tipoTransacao == 'Receita'
                      ? 'Salvar receita'
                      : 'Salvar despesa',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.close_rounded),
                label: const Text('Cancelar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF344054),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(color: Color(0xFFD7E2F0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({String? title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101828),
              ),
            ),
            const SizedBox(height: 14),
          ],
          child,
        ],
      ),
    );
  }

  Widget _buildTipoBotao(String tipo) {
    final selecionado = _tipoTransacao == tipo;

    return GestureDetector(
      onTap: () {
        setState(() {
          _tipoTransacao = tipo;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selecionado ? const Color(0xFFE8F1FF) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selecionado ? _primaryBlue : const Color(0xFFD7E2F0),
          ),
        ),
        child: Center(
          child: Text(
            tipo,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: selecionado ? _primaryBlue : const Color(0xFF667085),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (data != null) {
      setState(() {
        _dataSelecionada = data;
      });
    }
  }

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return '$dia/$mes/${data.year}';
  }

  void _salvarTransacao() {
    final mensagem = _tipoTransacao == 'Receita'
        ? 'Receita salva com sucesso!'
        : 'Despesa salva com sucesso!';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }
}