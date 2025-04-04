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
  double _acceleration = 0.0; // Valeur du slider (accélération en m/s²)
  double _velocity = 0.0; // Vitesse en m/s
  double _velocityKmh = 0.0; // Vitesse en km/h

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulated Speed (km/h)'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Simulated Speed:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),

            // Affichage de la vitesse
            Text(
              '${_velocityKmh.toStringAsFixed(2)} km/h',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            // Slider pour modifier l’accélération
            Text("Acceleration (m/s²)", style: TextStyle(fontSize: 16)),
            Slider(
              value: _acceleration,
              min: -5,
              max: 5,
              divisions: 40,
              label: _acceleration.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _acceleration = value;

                  // Simule une mise à jour de la vitesse toutes les 0.1 secondes
                  _velocity += _acceleration * 0.1; // v = v0 + at
                  _velocityKmh = _velocity * 3.6; // Conversion en km/h
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}