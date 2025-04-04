import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final String temperatureUnit;
  final ValueChanged<String> onUnitChanged;

  const SecondPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.temperatureUnit,
    required this.onUnitChanged,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late String selectedUnit;

  @override
  void initState() {
    super.initState();
    selectedUnit = widget.temperatureUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, selectedUnit);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Mode sombre"),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: widget.onThemeChanged,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Unité de température"),
            DropdownButton<String>(
              value: selectedUnit,
              items: const [
                DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
                DropdownMenuItem(value: "Fahrenheit", child: Text("Fahrenheit")),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedUnit = newValue;
                  });
                  widget.onUnitChanged(newValue);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
