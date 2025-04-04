import 'package:flutter/material.dart';
import 'second_page.dart';
import 'user_page.dart';
import 'thing_detail_page.dart'; 

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final String temperatureUnit;
  final ValueChanged<String> onUnitChanged;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.temperatureUnit,
    required this.onUnitChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double temperatureValue = 22.0; // Stocke la température en °C
  String selectedSensor = 'Tous'; // Valeur par défaut
  List<String> sensors = ['Tous', 'Température', 'Humidité', 'Accelération']; // Liste des capteurs

  // Fonction de conversion Celsius → Fahrenheit
  String _formatTemperature(double celsius, String unit) {
    if (unit == "Fahrenheit") {
      double fahrenheit = (celsius * 9 / 5) + 32;
      return "${fahrenheit.toStringAsFixed(1)}°F";
    }
    return "${celsius.toStringAsFixed(1)}°C";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final selectedUnit = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SecondPage(
                    isDarkMode: widget.isDarkMode,
                    onThemeChanged: widget.onThemeChanged,
                    temperatureUnit: widget.temperatureUnit,
                    onUnitChanged: widget.onUnitChanged,
                  ),
                ),
              );

              if (selectedUnit != null) {
                setState(() {}); // Force le rebuild après un changement d'unité
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserPage(
                    isDarkMode: widget.isDarkMode,
                    onThemeChanged: widget.onThemeChanged,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Ajout du filtre de sélection des capteurs
          DropdownButton<String>(
            value: selectedSensor,
            items: sensors.map((String sensor) {
              return DropdownMenuItem<String>(
                value: sensor,
                child: Text(sensor),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedSensor = newValue!;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: getFilteredSensors().map((sensor) {
                return Card(
                  child: ListTile(
                    title: Text(sensor),
                    subtitle: Text(getSensorValue(sensor)),
                    trailing: getSensorIcon(sensor),
                    onTap: () {
                      // Naviguer vers ThingDetailPage en passant les détails du capteur
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ThingDetailPage(
                            thing: {
                              "name": sensor,
                              "type": sensor, // Vous pouvez adapter cela selon vos besoins
                              "value": getSensorValue(sensor), // Valeur actuelle du capteur
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Récupère les capteurs filtrés selon la sélection
  List<String> getFilteredSensors() {
    if (selectedSensor == 'Tous') {
      return sensors.sublist(1); // Exclut "Tous" et retourne les capteurs
    } else {
      return [selectedSensor]; // Retourne uniquement le capteur sélectionné
    }
  }

  // Retourne la valeur du capteur
  String getSensorValue(String sensor) {
    switch (sensor) {
      case 'Température':
        return "Valeur: ${_formatTemperature(temperatureValue, widget.temperatureUnit)}";
      case 'Humidité':
        return "Valeur: 45%"; // Remplacez par la valeur réelle
      case 'Accelération':
        return "Valeur: 1 m/s"; // Remplacez par la valeur réelle
      default:
        return "";
    }
  }

  // Retourne l'icône du capteur
  Icon getSensorIcon(String sensor) {
    switch (sensor) {
      case 'Température':
        return const Icon(Icons.thermostat);
      case 'Humidité':
        return const Icon(Icons.water_drop);
      case 'Accelération':
        return const Icon(Icons.speed);
      default:
        return const Icon(Icons.help); // Icône par défaut
    }
  }
}
