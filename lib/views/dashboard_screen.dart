import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gambar Pondok (Wallpaper Utama)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1590076215667-875d4ef2d968?q=80&w=1000'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Layer gelap transparan agar tulisan elegan dan terbaca
          Container(color: Colors.black.withOpacity(0.6)),

          // 2. Konten Utama
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Nama Pondok & Identitas
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SANTRI-PASS",
                        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      Text(
                        "Pondok Pesantren Al-Hidayah", // Ganti dengan nama pondokmu
                        style: TextStyle(color: Colors.green[300], fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 3. Menu Fitur (Sesuai Blueprint & README)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Menu Layanan",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 20),
                        // Grid Menu Sesuai Fitur di Blueprint
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            children: [
                              _buildMenuCard(context, "Izin Digital", Icons.assignment_ind, Colors.greenAccent),
                              _buildMenuCard(context, "Kunjungan Tamu", Icons.group, Colors.blue),
                              _buildMenuCard(context, "Logistik/Titipan", Icons.inventory_2, Colors.orange),
                              _buildMenuCard(context, "Riwayat Kesehatan", Icons.medical_services, Colors.red),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat kotak fitur yang elegan
  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // Navigasi fitur bisa ditambahkan nanti sesuai materi Pertemuan 5
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Membuka fitur $title...")));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
          ],
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}