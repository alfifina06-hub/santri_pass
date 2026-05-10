import 'package:flutter/material.dart';
// Pastikan path import ini sesuai dengan nama folder dan file dashboard kamu
import 'package:santri_pass/views/dashboard_screen.dart'; 

void main() {
  runApp(const SantriPassApp());
}

class SantriPassApp extends StatelessWidget {
  const SantriPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santri-Pass',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      
      // Tema Aplikasi agar terlihat Elegan
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true, // Menggunakan gaya UI Android terbaru
        fontFamily: 'sans-serif', // Gunakan font bawaan yang bersih
      ),

      // MATERI PERTEMUAN 5: Manajemen Navigasi (Named Routes)
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/permit': (context) => const FeaturePlaceholder(title: "Digital Permit"),
        '/visit': (context) => const FeaturePlaceholder(title: "Log Tamu"),
        '/health': (context) => const FeaturePlaceholder(title: "Catatan Kesehatan"),
        '/logistic': (context) => const FeaturePlaceholder(title: "Titipan Barang"),
      },
    );
  }
}

// Widget sederhana untuk halaman fitur yang belum dibuat
// Agar saat diklik tidak error, tapi muncul halaman transisi
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