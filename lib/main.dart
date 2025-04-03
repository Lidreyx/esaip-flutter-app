import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: AccelerometerExample(),
    );
  }
}

class AccelerometerExample extends StatefulWidget {
  const AccelerometerExample({super.key});

  @override
  State<AccelerometerExample> createState() => _AccelerometerExampleState();
}

class _AccelerometerExampleState extends State<AccelerometerExample> {
  // Variable pour stocker la dernière valeur de l'accéléromètre
  AccelerometerEvent? _accelerometerEvent;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    // Écoute les événements de l'accéléromètre
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerEvent = event;
      });
    });
  }

  @override
  void dispose() {
    // Annule l'abonnement pour éviter les fuites de mémoire
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accelerometer Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Accelerometer Data:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            if (_accelerometerEvent != null)
              Text(
                'X: ${_accelerometerEvent!.x.toStringAsFixed(2)}, '
                'Y: ${_accelerometerEvent!.y.toStringAsFixed(2)}, '
                'Z: ${_accelerometerEvent!.z.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              )
            else
              Text('No data available', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}