import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import du package de graphes

class HistoricalPage extends StatelessWidget {
  final String thingName;

  const HistoricalPage({super.key, required this.thingName});

  @override
  Widget build(BuildContext context) {
    // Exemple de fausses valeurs d'historique
    List<Map<String, dynamic>> historicalValues = [
      {"timestamp": "2025-04-01 10:00", "value": 21.5},
      {"timestamp": "2025-04-01 11:00", "value": 22.0},
      {"timestamp": "2025-04-01 12:00", "value": 23.5},
      {"timestamp": "2025-04-01 13:00", "value": 24.0},
      {"timestamp": "2025-04-01 14:00", "value": 22.5},
    ];

    List<FlSpot> _generateGraphPoints() {
      return List.generate(historicalValues.length, (index) {
        return FlSpot(index.toDouble(), historicalValues[index]["value"]);
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('$thingName - Historique')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Historique des valeurs :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: historicalValues.length,
                itemBuilder: (context, index) {
                  final item = historicalValues[index];
                  return Card(
                    child: ListTile(
                      title: Text("Valeur : ${item["value"]}"),
                      subtitle: Text("Date : ${item["timestamp"]}"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text("Graphique", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < historicalValues.length) {
                            return Text(
                              historicalValues[value.toInt()]["timestamp"].substring(11, 13),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      spots: _generateGraphPoints(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
