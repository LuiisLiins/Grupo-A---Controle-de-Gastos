import 'package:flutter/material.dart';

class TipoSelector extends StatelessWidget {
  final String tipoAtual;
  final Function(String) onChanged;

  const TipoSelector({
    super.key,
    required this.tipoAtual,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        height: 58,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE5E5EA),
          ),
        ),
        child: Row(
          children: [
            _botao(
              texto: 'Despesa',
              cor: const Color(0xFFFF3B30),
              icon: Icons.arrow_downward_rounded,
            ),
            _botao(
              texto: 'Receita',
              cor: const Color(0xFF34C759),
              icon: Icons.arrow_upward_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _botao({
    required String texto,
    required Color cor,
    required IconData icon,
  }) {
    final ativo = tipoAtual == texto;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(texto),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: ativo ? cor : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: ativo
                ? [
                    BoxShadow(
                      color: cor.withOpacity(0.22),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  icon,
                  key: ValueKey(ativo),
                  size: 18,
                  color: ativo ? Colors.white : cor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                texto,
                style: TextStyle(
                  color: ativo ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}