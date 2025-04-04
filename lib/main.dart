import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

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
  double _acceleration = 0.0; // Accélération actuelle en m/s²
  double _velocity = 0.0; // Vitesse en m/s
  double _velocityKmh = 0.0; // Vitesse en km/h
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  void _startSimulation() {
    _timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      setState(() {
        // Génère une accélération simulée entre -3 et 3 m/s²
        _acceleration = (_random.nextDouble() * 6) - 3;

        // Mise à jour de la vitesse (v = v0 + at)
        _velocity += _acceleration * 0.1; 
        _velocityKmh = _velocity * 3.6; // Conversion en km/h
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Arrêter la simulation lors de la fermeture
    super.dispose();
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
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}