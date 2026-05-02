import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficoCard extends StatelessWidget {
  const GraficoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(alignment: Alignment.centerLeft, child: Text('Resumo do mês', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            SizedBox(
              height: 240,
              child: PieChart(PieChartData(sections: [
                PieChartSectionData(value: 40, color: Colors.blue, showTitle: false),
                PieChartSectionData(value: 25, color: Colors.orange, showTitle: false),
                PieChartSectionData(value: 20, color: Colors.green, showTitle: false),
                PieChartSectionData(value: 15, color: Colors.purple, showTitle: false),
              ])),
            )
          ],
        ),
      ),
    );
  }
}