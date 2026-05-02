import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Data dummy sesuai materi OOP Pertemuan 2
  final List<Map<String, dynamic>> santriKeluar = [
    {'nama': 'Ahmad Fauzi', 'tujuan': 'Pasar Desa', 'status': 'Izin'},
    {'nama': 'Zainuddin', 'tujuan': 'Rumah (Sakit)', 'status': 'Sakit'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Santri-Pass Dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: santriKeluar.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: Text(santriKeluar[index]['nama']),
              subtitle: Text("Tujuan: ${santriKeluar[index]['tujuan']}"),
            ),
          );
        },
      ),
    );
  }
}