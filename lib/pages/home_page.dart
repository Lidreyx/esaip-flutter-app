import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart'; // Import pour fl_chart
import 'second_page.dart';
import 'dart:convert'; // Pour parser le JSON (utile plus tard)

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.isDarkMode, required this.toggleTheme});

  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Liste des données simulées
  List<Map<String, dynamic>> sensorData = [
    {"name": "Température", "value": "22°C"},
    {"name": "Humidité", "value": "55%"},
    {"name": "Pression", "value": "1013 hPa"},
  ];

  // Fonction simulée pour récupérer des données JSON (à remplacer par les vraies données plus tard)
  void fetchSensorData() {
    String jsonData = '''
      [
        {"name": "Température", "value": "23°C"},
        {"name": "Humidité", "value": "58%"},
        {"name": "Pression", "value": "1011 hPa"}
      ]
    ''';

    setState(() {
      sensorData = List<Map<String, dynamic>>.from(json.decode(jsonData));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Données des capteurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh), // Icône de rafraîchissement
            onPressed: fetchSensorData,
            tooltip: "Rafraîchir les données",
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage(
                    isDarkMode: widget.isDarkMode, 
                    toggleTheme: widget.toggleTheme,
                  ),
                ),
              );
            },
            tooltip: "Paramètres",
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: sensorData.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: ListTile(
                      title: Text(sensorData[index]["name"]),
                      subtitle: Text(sensorData[index]["value"]),
                      leading: const Icon(Icons.sensors),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h), // Espacement avant le graphique
            const Text(
              "Évolution Température & Humidité :",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(1, 22),
                        const FlSpot(2, 24),
                        const FlSpot(3, 21.8),
                      ],
                      isCurved: true,
                      color: Colors.blue, // Température
                      barWidth: 4,
                    ),
                    LineChartBarData(
                      spots: [
                        const FlSpot(1, 60),
                        const FlSpot(2, 55),
                        const FlSpot(3, 62),
                      ],
                      isCurved: true,
                      color: Colors.green, // Humidité
                      barWidth: 4,
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
