import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'user_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.isDarkMode, required this.toggleTheme});

  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // Icône bonhomme
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPage(
                    isDarkMode: widget.isDarkMode,
                    toggleTheme: widget.toggleTheme,
                  ),
                ),
              );
            },
            tooltip: "Page utilisateur",
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h), // Espace sous le titre
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mode sombre",
                  style: TextStyle(fontSize: 18.sp),
                ),
                SizedBox(width: 10.w),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) => widget.toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
