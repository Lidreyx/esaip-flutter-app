import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;
  String _temperatureUnit = "Celsius"; // Stocke l'unité actuelle

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  void _setTemperatureUnit(String unit) {
    setState(() {
      _temperatureUnit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: HomePage(
            isDarkMode: _isDarkMode,
            onThemeChanged: _toggleTheme,
            temperatureUnit: _temperatureUnit,
            onUnitChanged: _setTemperatureUnit, // On passe cette fonction à HomePage
          ),
        );
      },
    );
  }
}
