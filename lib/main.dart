import 'package:flutter/material.dart';
import 'package:santri_pass/views/dashboard_screen.dart'; 
import 'package:santri_pass/views/splash_screen.dart';
import 'package:santri_pass/views/login_screen.dart';
import 'package:santri_pass/views/attendance_screen.dart';
import 'package:santri_pass/views/visit_screen.dart';
import 'package:santri_pass/views/logistic_screen.dart';
import 'package:santri_pass/views/health_screen.dart';
void main() {
  runApp(const SantriPassApp());
}

class SantriPassApp extends StatelessWidget {
  const SantriPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santri-Pass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        fontFamily: 'sans-serif', 
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/attendance': (context) => const AttendanceScreen(),
        '/visit': (context) => const VisitScreen(),
        '/health': (context) => const HealthScreen(),
        '/logistic': (context) => const LogisticScreen(),
      },
    );
  }
}

class FeaturePlaceholder extends StatelessWidget {
  final String title;
  const FeaturePlaceholder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            Text(
              "Halaman $title sedang dikembangkan",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Kembali ke Dashboard"),
            )
          ],
        ),
      ),
    );
  }
}