import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.isDarkMode, required this.toggleTheme});

  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page utilisateur"),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      isDarkMode: widget.isDarkMode, 
                      toggleTheme: widget.toggleTheme,
                    ),
                  ),
                  (route) => false, // Supprime tout l'historique et retourne à l'accueil
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center, 
        children: [
          Column(
            children: <Widget>[
              const Text(
                "Bienvenue sur la page utilisateur !",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                height: 40.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF65558F),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                height: 40.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF65558F),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
