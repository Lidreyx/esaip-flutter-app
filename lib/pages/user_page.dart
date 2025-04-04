// user_page.dart
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const UserPage({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil utilisateur")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bienvenue sur votre profil"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Mode sombre"),
                Switch(
                  value: isDarkMode,
                  onChanged: onThemeChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
