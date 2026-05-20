import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isListExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Data dummy yang lebih banyak
  final List<Map<String, dynamic>> _santriList = [
    {
      'name': 'Ahmad Zaini',
      'class': 'Kelas 12-A',
      'building': 'Gedung Al-Ikhlas',
      'status': 'DI DALAM',
      'timeLabel': 'Masuk: 04:30 WIB',
      'statusColor': const Color(0xFF1B5E20), 
      'statusBgColor': Colors.greenAccent.shade200, 
      'iconColor': Colors.white,
      'avatarColor': const Color(0xFF1B5E20), 
    },
    {
      'name': 'Ahmad Zaki Al-Fatih',
      'class': 'Kelas 12-A',
      'building': 'Gedung Al-Ikhlas',
      'status': 'DI DALAM',
      'timeLabel': 'Masuk: 04:30 WIB',
      'statusColor': const Color(0xFF1B5E20), 
      'statusBgColor': Colors.greenAccent.shade200, 
      'iconColor': Colors.white,
      'avatarColor': const Color(0xFF1B5E20), 
    },
    {
      'name': 'Ahmad Fauzi',
      'class': 'Kelas 11-B',
      'building': 'Gedung Ar-Rayyan',
      'status': 'IZIN KELUAR',
      'timeLabel': 'Keluar: 10:45 WIB',
      'statusColor': const Color(0xFF1B5E20), 
      'statusBgColor': Colors.greenAccent.shade200, 
      'iconColor': Colors.grey.shade400,
      'avatarColor': Colors.grey.shade200,
    },
    {
      'name': 'Zaini Majid',
      'class': 'Kelas 10-A',
      'building': 'Gedung An-Nur',
      'status': 'DI DALAM',
      'timeLabel': 'Masuk: 18:30 WIB',
      'statusColor': const Color(0xFF1B5E20),
      'statusBgColor': Colors.greenAccent.shade200,
      'iconColor': Colors.white,
      'avatarColor': const Color(0xFF1B5E20),
    },
    {
      'name': 'Muhammad Rizky',
      'class': 'Kelas 10-C',
      'building': 'Gedung An-Nur',
      'status': 'IZIN KELUAR',
      'timeLabel': 'Keluar: 08:15 WIB',
      'statusColor': const Color(0xFF1B5E20), 
      'statusBgColor': Colors.greenAccent.shade200, 
      'iconColor': Colors.grey.shade400,
      'avatarColor': Colors.grey.shade200,
    },
    {
      'name': 'Faisal Rahman',
      'class': 'Kelas 11-B',
      'building': 'Gedung Ar-Rayyan',
      'status': 'TERLAMBAT',
      'timeLabel': 'Deadline: 17:00 WIB',
      'statusColor': Colors.red.shade700,
      'statusBgColor': Colors.red.shade100,
      'iconColor': Colors.red.shade700,
      'avatarColor': Colors.red.shade100,
      'timeLabelColor': Colors.red.shade700,
    },
    {
      'name': 'Hafizh Syahputra',
      'class': 'Kelas 12-A',
      'building': 'Gedung Al-Ikhlas',
      'status': 'DI DALAM',
      'timeLabel': 'Masuk: 12:45 WIB',
      'statusColor': const Color(0xFF1B5E20),
      'statusBgColor': Colors.greenAccent.shade200,
      'iconColor': Colors.white,
      'avatarColor': const Color(0xFF1B5E20),
    },
    {
      'name': 'Ahmad Rabbani',
      'class': 'Kelas 12-C',
      'building': 'Gedung Al-Ikhlas',
      'status': 'DI DALAM',
      'timeLabel': 'Masuk: 15:20 WIB',
      'statusColor': const Color(0xFF1B5E20),
      'statusBgColor': Colors.greenAccent.shade200,
      'iconColor': Colors.white,
      'avatarColor': const Color(0xFF1B5E20),
    },
    {
      'name': 'Ilham Zaini Akbar',
      'class': 'Kelas 10-B',
      'building': 'Gedung An-Nur',
      'status': 'IZIN KELUAR',
      'timeLabel': 'Keluar: 14:15 WIB',
      'statusColor': const Color(0xFF1B5E20),
      'statusBgColor': Colors.greenAccent.shade200,
      'iconColor': Colors.grey.shade400,
      'avatarColor': Colors.grey.shade200,
    },
    {
      'name': 'Ridho Pratama',
      'class': 'Kelas 11-A',
      'building': 'Gedung Ar-Rayyan',
      'status': 'TERLAMBAT',
      'timeLabel': 'Deadline: 20:00 WIB',
      'statusColor': Colors.red.shade700,
      'statusBgColor': Colors.red.shade100,
      'iconColor': Colors.red.shade700,
      'avatarColor': Colors.red.shade100,
      'timeLabelColor': Colors.red.shade700,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 1. Filter list realtime
    List<Map<String, dynamic>> filteredSantriList = _santriList.where((santri) {
      return santri['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF004D28),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya (Dashboard)
          },
        ),
        title: const Text(
          "Status Kehadiran Santri",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monitoring real-time aktivitas keluar-masuk pondok.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),

            // Statistics Cards
            _buildStatCard(
              title: "Di Dalam Pondok",
              count: "1,248",
              chipLabel: "94% Total",
              chipColor: const Color(0xFF1B5E20),
              chipBgColor: Colors.greenAccent.shade200,
              icon: Icons.home_outlined,
              iconColor: const Color(0xFF004D28),
              countColor: const Color(0xFF004D28),
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              title: "Izin Keluar",
              count: "52",
              chipLabel: "4.2% Total",
              chipColor: Colors.grey.shade500,
              chipBgColor: Colors.grey.shade200,
              icon: Icons.directions_bus_outlined, 
              iconColor: Colors.grey.shade600,
              countColor: Colors.black87,
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              title: "Terlambat",
              count: "12",
              chipLabel: "Tindakan Diperlukan",
              chipColor: Colors.red.shade700,
              chipBgColor: Colors.red.shade100,
              icon: Icons.alarm,
              iconColor: Colors.red.shade700,
              countColor: Colors.red.shade700,
            ),
            const SizedBox(height: 24),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    if (value.isNotEmpty) {
                      _isListExpanded = true;
                    }
                  });
                },
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Cari nama santri (contoh: ahmad zaini)...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isNotEmpty 
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        ) 
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Daftar Aktif Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  // Header (Clickable for Expand/Collapse)
                  InkWell(
                    borderRadius: _isListExpanded
                        ? const BorderRadius.vertical(top: Radius.circular(16))
                        : BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        _isListExpanded = !_isListExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Daftar Santri",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004D28),
                            ),
                          ),
                          Icon(
                            _isListExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  if (_isListExpanded) ...[
                    const Divider(height: 1),
                    // List
                    if (filteredSantriList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.search_off, size: 48, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                "Santri tidak ditemukan",
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredSantriList.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final santri = filteredSantriList[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                // Auto-fill the search box with the selected name
                                _searchController.text = santri['name'];
                                _searchQuery = santri['name'];
                                // Move cursor to the end
                                _searchController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: _searchController.text.length)
                                );
                              });
                              // Hide keyboard after selection
                              FocusScope.of(context).unfocus();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: santri['avatarColor'],
                                    child: Icon(Icons.person_outline, color: santri['iconColor']),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          santri['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${santri['class']} • ${santri['building']}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: santri['statusBgColor'],
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.circle, size: 8, color: santri['statusColor']),
                                            const SizedBox(width: 6),
                                            Text(
                                              santri['status'],
                                              style: TextStyle(
                                                color: santri['statusColor'],
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        santri['timeLabel'],
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: santri['timeLabelColor'] ?? Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    if (filteredSantriList.isNotEmpty)
                      const Divider(height: 1),
                    if (filteredSantriList.isNotEmpty)
                      InkWell(
                        onTap: () {
                          // Placeholder for navigating to a full list page if needed
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "LIHAT SEMUA SANTRI",
                              style: TextStyle(
                                color: Color(0xFF004D28),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 80), 
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF004D28), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required String chipLabel,
    required Color chipColor,
    required Color chipBgColor,
    required IconData icon,
    required Color iconColor,
    required Color countColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              Icon(icon, color: iconColor),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: countColor,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: chipBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  chipLabel,
                  style: TextStyle(
                    color: chipColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
