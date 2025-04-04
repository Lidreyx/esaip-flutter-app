import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'historicalPage.dart';

class ThingDetailPage extends StatefulWidget {
  final Map<String, dynamic> thing;

  const ThingDetailPage({super.key, required this.thing});

  @override
  State<ThingDetailPage> createState() => _ThingDetailPageState();
}

class _ThingDetailPageState extends State<ThingDetailPage> {
  late TextEditingController _locationController; // Pour gérer la saisie de l'emplacement
  String serialNumber = 'SN123456'; // Faux numéro de série du client
  String? updateFrequency; // Fréquence de mise à jour sélectionnée
  final List<String> frequencies = ['5 secondes', '10 secondes', '30 secondes'];

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: "Salon"); // Valeur par défaut
    _loadData(); // Charger l'emplacement et la fréquence enregistrés
  }

  @override
  void dispose() {
    _locationController.dispose(); // Libérer le contrôleur
    super.dispose();
  }

  // Charger les données à partir de SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocation = prefs.getString(widget.thing["name"] + "_location");
    String? savedFrequency = prefs.getString(widget.thing["name"] + "_frequency");
    
    if (savedLocation != null) {
      _locationController.text = savedLocation; // Mettre à jour le champ de texte
    }
    if (savedFrequency != null) {
      setState(() {
        updateFrequency = savedFrequency; // Mettre à jour la fréquence de mise à jour
      });
    }
  }

  // Sauvegarder la valeur de l'emplacement et la fréquence dans SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(widget.thing["name"] + "_location", _locationController.text);
    await prefs.setString(widget.thing["name"] + "_frequency", updateFrequency ?? '5 secondes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.thing["name"])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type : ${widget.thing["type"]}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Valeur actuelle : ${widget.thing["value"]}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Numéro de série : $serialNumber", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Attribut du serveur :", style: const TextStyle(fontSize: 16)),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Entrez l\'emplacement (ex: Salon)',
              ),
            ),
            const SizedBox(height: 10),
            Text("Fréquence de mise à jour :", style: const TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: updateFrequency,
              hint: const Text('Sélectionnez une fréquence'),
              items: frequencies.map((String frequency) {
                return DropdownMenuItem<String>(
                  value: frequency,
                  child: Text(frequency),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  updateFrequency = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveData(); // Enregistrer l'emplacement et la fréquence lorsque l'on quitte
                Navigator.pop(context);
              },
              child: const Text("Retour"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoricalPage(thingName: widget.thing["name"]),
                  ),
                );
              },
              child: const Text("Voir l'historique des valeurs"),
            ),
          ],
        ),
      ),
    );
  }
}
