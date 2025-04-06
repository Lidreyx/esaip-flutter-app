import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: AccelerometerSimulation(),
    );
  }
}

class AccelerometerSimulation extends StatefulWidget {
  const AccelerometerSimulation({Key? key}) : super(key: key);

  @override
  State<AccelerometerSimulation> createState() =>
      _AccelerometerSimulationState();
}

class _AccelerometerSimulationState extends State<AccelerometerSimulation> {
  double _acceleration = 0.0; // Accélération en m/s²
  double _velocity = 0.0; // Vitesse en m/s
  double _velocityKmh = 0.0; // Vitesse en km/h
  Timer? _timer;
  List<FlSpot> _velocityData = []; // Liste des points pour le graphique
  int _time = 0; // Compteur de temps

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  void _startSimulation() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        _velocity += _acceleration * 10; 
        _velocityKmh = _velocity * 3.6; // Conversion en km/h
        _time++;

        // Ajouter un point au graphique (max 50 points affichés)
        _velocityData.add(FlSpot(_time.toDouble(), _velocityKmh));
        if (_velocityData.length > 50) {
          _velocityData.removeAt(0); // Supprime les anciens points
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetSimulation() {
    setState(() {
      _velocity = 0.0;
      _velocityKmh = 0.0;
      _acceleration = 0.0;
      _velocityData.clear();
      _time = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulated Accelerometer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _resetSimulation,
              child: Text("Réinitialiser"),
            ),
            SizedBox(height: 20),
            Text('Simulated Speed:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),

            // Affichage de la vitesse
            Text(
              '${_velocityKmh.toStringAsFixed(2)} km/h',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),
            Text("Acceleration: ${_acceleration.toStringAsFixed(2)} m/s²"),

            SizedBox(height: 20),
            Text("Adjust Acceleration:"),
            Slider(
              value: _acceleration,
              min: -3.0,
              max: 3.0,
              divisions: 30,
              label: _acceleration.toStringAsFixed(2),
              onChanged: (value) {
                setState(() {
                  _acceleration = value;
                });
              },
            ),

            SizedBox(height: 20),

            // Graphique de la vitesse
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _velocityData,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.green,
                      dotData: FlDotData(show: false),
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
