import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Diubah ke white agar background konten terlihat bersih
      body: Stack(
        children: [
          // 1. BACKGROUND IMAGE (Full Screen)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_pesantren.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.darken),
              ),
            ),
          ),
          
          // 2. KONTEN UTAMA (Scrollable)
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(), // Memanggil Header Hijau
                  _buildHighlightCard(), // Memanggil Kartu Info (Penting: harus dipanggil di sini)
                  
                  // 3. MENU TITLE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Row(
                      children: [
                        Text("Layanan Utama",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87)),
                      ],
                    ),
                  ),

                  // 4. GRID MENU FITUR
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.1,
                      children: [
                        _buildMenuItem(context, "Digital Permit", Icons.assignment_ind, Colors.blue, '/permit'),
                        _buildMenuItem(context, "Log Tamu", Icons.people_alt, Colors.orange, '/visit'),
                        _buildMenuItem(context, "Kesehatan", Icons.monitor_heart, Colors.redAccent, '/health'),
                        _buildMenuItem(context, "Titipan", Icons.inventory_2, Colors.purple, '/logistic'),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- SEMUA FUNGSI DI BAWAH INI TETAP SAMA SEPERTI KODE KAMU ---

  Widget _buildHeader() {
    return Container(
      height: 220,
      padding: EdgeInsets.only(top: 60, left: 25, right: 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Assalamu'alaikum wr wb,", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text("Ahlan wasahlan", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard() {
    return Transform.translate(
      offset: Offset(0, -30), // Mengatur posisi agar mengambang di antara header dan body
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 2),
          ],
        ),
        child: IntrinsicHeight( // Agar Divider bisa muncul
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _infoItem("12", "Izin Aktif"),
              VerticalDivider(color: Colors.grey),
              _infoItem("450", "Santri"),
              VerticalDivider(color: Colors.grey),
              _infoItem("5", "Tamu Hari Ini"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[800])),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, Color color, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(height: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}