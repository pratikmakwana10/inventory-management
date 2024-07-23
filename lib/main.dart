import 'package:flutter/material.dart';
import 'package:inventory_software/pages.dart/dashboard_pg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management',
      theme: ThemeData(
        //oidsjv

        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: const DashboardScreen(),
      //dashboard
    );
  }
}
