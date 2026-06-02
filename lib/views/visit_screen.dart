import 'dart:math';
import 'package:flutter/material.dart';

class VisitScreen extends StatefulWidget {
  const VisitScreen({super.key});

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _visitorNameController = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentClassController = TextEditingController();
  String _searchQuery = '';

  static final List<Map<String, dynamic>> _visitList = [
    {
      'visitorName': 'H. Ahmad Fauzi',
      'studentName': 'Abdullah Fauzi',
      'studentClass': 'Grade 10-A',
      'checkInTime': '09:15 AM',
      'visitorId': '#VP-2940',
      'status': 'AKTIF',
      'isActive': true,
    },
    {
      'visitorName': 'Ibu Siti Aminah',
      'studentName': 'Fatimah Azzahra',
      'studentClass': 'Grade 12-C',
      'checkInTime': '08:00 AM',
      'duration': '45 Minutes',
      'status': 'SELESAI',
      'isActive': false,
    },
    {
      'visitorName': 'Bpk. Bambang S.',
      'studentName': 'Rizky Pratama',
      'studentClass': 'Grade 11-B',
      'checkInTime': '10:30 AM',
      'visitorId': '#VP-2945',
      'status': 'AKTIF',
      'isActive': true,
    },
    {
      'visitorName': 'Ibu Dewi Rahayu',
      'studentName': 'Nurul Hidayah',
      'studentClass': 'Grade 10-C',
      'checkInTime': '07:45 AM',
      'duration': '60 Minutes',
      'status': 'SELESAI',
      'isActive': false,
    },
    {
      'visitorName': 'Bpk. Hendra W.',
      'studentName': 'Ahmad Fauzi',
      'studentClass': 'Grade 11-A',
      'checkInTime': '11:00 AM',
      'visitorId': '#VP-2948',
      'status': 'AKTIF',
      'isActive': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _visitorNameController.dispose();
    _studentNameController.dispose();
    _studentClassController.dispose();
    super.dispose();
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    int hour = now.hour;
    final String ampm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    final minuteStr = now.minute.toString().padLeft(2, '0');
    final hourStr = hour.toString().padLeft(2, '0');
    return "$hourStr:$minuteStr $ampm";
  }

  void _showAddVisitDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24, right: 24, top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tambah Kunjungan Baru',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildInputField('Nama Wali Santri', Icons.person_outline, 'Contoh: H. Ahmad Fauzi', _visitorNameController),
              const SizedBox(height: 12),
              _buildInputField('Nama Santri yang Dikunjungi', Icons.school_outlined, 'Contoh: Abdullah Fauzi', _studentNameController),
              const SizedBox(height: 12),
              _buildInputField('Kelas Santri', Icons.class_outlined, 'Contoh: Grade 10-A', _studentClassController),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final visitorName = _visitorNameController.text.trim();
                    final studentName = _studentNameController.text.trim();
                    final studentClass = _studentClassController.text.trim();

                    if (visitorName.isEmpty || studentName.isEmpty || studentClass.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Semua field harus diisi!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final random = Random();
                    final randomId = '#VP-${random.nextInt(9000) + 1000}';
                    final checkInStr = _getFormattedTime();

                    setState(() {
                      _searchQuery = '';
                      _searchController.clear();
                      _visitList.insert(0, {
                        'visitorName': visitorName,
                        'studentName': studentName,
                        'studentClass': studentClass,
                        'checkInTime': checkInStr,
                        'visitorId': randomId,
                        'status': 'AKTIF',
                        'isActive': true,
                      });
                    });

                    // Clear fields
                    _visitorNameController.clear();
                    _studentNameController.clear();
                    _studentClassController.clear();

                    Navigator.pop(context);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Kunjungan berhasil disimpan!'),
                        backgroundColor: Color(0xFF004D28),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                  label: const Text('Simpan Kunjungan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D28),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputField(String label, IconData icon, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey, size: 20),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _visitList.where((v) {
      final q = _searchQuery.toLowerCase();
      return v['visitorName'].toString().toLowerCase().contains(q) ||
          v['studentName'].toString().toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF004D28),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Santri-Pass',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.green.shade200,
              child: const Icon(Icons.person, color: Color(0xFF004D28), size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log Kunjungan Wali Santri',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Monitoring and manage visitor access in real-time.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),
                // Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.grey.shade400),
                      hintText: 'Search parent or student name...',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      border: InputBorder.none,
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Add Visit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showAddVisitDialog,
                    icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                    label: const Text(
                      'Add Visit',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D28),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // List of visits
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 60, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Kunjungan tidak ditemukan',
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return _buildVisitCard(filtered[index]);
                    },
                  ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildVisitCard(Map<String, dynamic> visit) {
    final bool isActive = visit['isActive'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: avatar + name + status badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: isActive ? Colors.green.shade100 : Colors.grey.shade200,
                  child: Icon(
                    Icons.person_outline,
                    color: isActive ? const Color(0xFF004D28) : Colors.grey.shade500,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visit['visitorName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.school_outlined, size: 13, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            'Student: ${visit['studentName']} (${visit['studentClass']})',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF004D28) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    visit['status'],
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey.shade600,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Check-in time + ID/Duration row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check-in Time',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                      const SizedBox(height: 4),
                      Text(
                        visit['checkInTime'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(isActive ? 'Visitor ID' : 'Duration',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                      const SizedBox(height: 4),
                      Text(
                        isActive ? visit['visitorId'] ?? '-' : visit['duration'] ?? '-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isActive ? const Color(0xFF004D28) : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Check-out button for active visits
            if (isActive) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      final index = _visitList.indexWhere((element) => element['visitorId'] == visit['visitorId']);
                      if (index != -1) {
                        _visitList[index]['isActive'] = false;
                        _visitList[index]['status'] = 'SELESAI';
                        _visitList[index]['duration'] = '15 Minutes';
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengunjung berhasil check-out!'),
                        backgroundColor: Color(0xFF004D28),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Check-out',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard_outlined, 'Dashboard', false, () {
                Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
              }),
              _buildNavItem(Icons.people_alt_outlined, 'Visitors', true, () {}),
              _buildNavItem(Icons.inventory_2_outlined, 'Logistics', false, () {
                Navigator.pushNamed(context, '/logistic');
              }),
              _buildNavItem(Icons.health_and_safety_outlined, 'Health', false, () {
                Navigator.pushNamed(context, '/health');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF004D28) : Colors.grey.shade500, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? const Color(0xFF004D28) : Colors.grey.shade500,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
