import 'package:flutter/material.dart';
import 'views/dashboard_screen.dart';
void main() {
  runApp(const SantriPassApp());
}

class SantriPassApp extends StatelessWidget {
  const SantriPassApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Santri_Pass',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/' : (context) => const DashboardScreen(),

        },
    );
        
  }
}

