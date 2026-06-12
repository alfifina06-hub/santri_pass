import 'package:flutter/material.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'Semua';

  // Controllers for reporting health issue
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _symptomController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();
  String _selectedStatus = 'OBSERVASI';

  // README: Menggunakan List<Map> sebagai sumber data
  final List<Map<String, dynamic>> _healthList = [
    {
      'name': 'Ahmad Zaki',
      'initials': 'AZ',
      'room': 'Kamar Al-Fatih 04',
      'status': 'OBSERVASI',
      'gejala': 'Demam & Batuk',
      'perawatan': 'Kamar (Istirahat)',
      'date': '24 Okt 2023, 08:30',
      'avatarColor': Color(0xFF2E7D32),
    },
    {
      'name': 'Muhammad Farhan',
      'initials': 'MF',
      'room': 'Kamar Khalid 02',
      'status': 'SEMBUH',
      'gejala': 'Flu Ringan',
      'perawatan': 'Poli Klinik',
      'date': '23 Okt 2023, 14:15',
      'avatarColor': Color(0xFF1565C0),
    },
    {
      'name': 'Rizky Kurniawan',
      'initials': 'RK',
      'room': 'Kamar Zubair 01',
      'status': 'KLINIK',
      'gejala': 'Tipus (Gejala)',
      'perawatan': 'RS Rujukan',
      'date': '22 Okt 2023, 19:45',
      'avatarColor': Color(0xFFC62828),
    },
    {
      'name': 'Umar Al-Khattab',
      'initials': 'UA',
      'room': 'Kamar Hamzah 05',
      'status': 'SEMBUH',
      'gejala': 'Pusing',
      'perawatan': 'Istirahat Kamar',
      'date': '21 Okt 2023, 10:00',
      'avatarColor': Color(0xFF6A1B9A),
    },
    {
      'name': 'Hafizh Syahputra',
      'initials': 'HS',
      'room': 'Kamar Bilal 03',
      'status': 'RUMAH',
      'gejala': 'Cedera Kaki',
      'perawatan': 'Rawat di Rumah',
      'date': '20 Okt 2023, 07:00',
      'avatarColor': Color(0xFF00695C),
    },
    {
      'name': 'Faisal Ramadhan',
      'initials': 'FR',
      'room': 'Kamar Umar 06',
      'status': 'KLINIK',
      'gejala': 'Asma Kambuh',
      'perawatan': 'Poli Klinik',
      'date': '19 Okt 2023, 21:30',
      'avatarColor': Color(0xFF4E342E),
    },
  ];

  final List<String> _filters = ['Semua', 'Observasi', 'Klinik', 'Rumah', 'Sembuh'];

  @override
  void dispose() {
    _searchController.dispose();
    _studentNameController.dispose();
    _roomController.dispose();
    _symptomController.dispose();
    _treatmentController.dispose();
    super.dispose();
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'S';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  Color _getRandomAvatarColor(String name) {
    final colors = [
      const Color(0xFF2E7D32),
      const Color(0xFF1565C0),
      const Color(0xFFC62828),
      const Color(0xFF6A1B9A),
      const Color(0xFF00695C),
      const Color(0xFF4E342E),
      const Color(0xFFE65100),
    ];
    return colors[name.hashCode % colors.length];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'SEMBUH':
        return const Color(0xFF2E7D32);
      case 'OBSERVASI':
        return const Color(0xFFE65100);
      case 'KLINIK':
        return const Color(0xFF1565C0);
      case 'RUMAH':
        return const Color(0xFFC62828);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'SEMBUH':
        return const Color(0xFFE8F5E9);
      case 'OBSERVASI':
        return const Color(0xFFFFF3E0);
      case 'KLINIK':
        return const Color(0xFFE3F2FD);
      case 'RUMAH':
        return const Color(0xFFFFEBEE);
      default:
        return Colors.grey.shade100;
    }
  }

  String _getFormattedDateTime() {
    final now = DateTime.now();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    final monthStr = months[now.month - 1];
    final minuteStr = now.minute.toString().padLeft(2, '0');
    final hourStr = now.hour.toString().padLeft(2, '0');
    return "${now.day} $monthStr ${now.year}, $hourStr:$minuteStr";
  }

  void _showLaporDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Lapor Riwayat Kesehatan Baru',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField('Nama Santri', Icons.person_outline, 'Contoh: Ahmad Zaki', _studentNameController),
                  const SizedBox(height: 12),
                  _buildInputField('Kamar', Icons.bed_outlined, 'Contoh: Kamar Al-Fatih 04', _roomController),
                  const SizedBox(height: 12),
                  _buildInputField('Gejala', Icons.sick_outlined, 'Contoh: Demam & Batuk', _symptomController),
                  const SizedBox(height: 12),
                  _buildDropdownField(
                    'Status Awal / Lokasi',
                    Icons.local_hospital_outlined,
                    _selectedStatus,
                    ['OBSERVASI', 'KLINIK', 'RUMAH'],
                    (val) {
                      if (val != null) {
                        setModalState(() {
                          _selectedStatus = val;
                          // Suggest default treatment based on selected status
                          if (_treatmentController.text.trim().isEmpty) {
                            if (_selectedStatus == 'OBSERVASI') {
                              _treatmentController.text = 'Kamar (Istirahat)';
                            } else if (_selectedStatus == 'KLINIK') {
                              _treatmentController.text = 'Poli Klinik';
                            } else if (_selectedStatus == 'RUMAH') {
                              _treatmentController.text = 'Rawat di Rumah';
                            }
                          }
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildInputField(
                    'Tindakan Perawatan',
                    Icons.healing_outlined,
                    _selectedStatus == 'OBSERVASI'
                        ? 'Contoh: Kamar (Istirahat)'
                        : (_selectedStatus == 'KLINIK' ? 'Contoh: Poli Klinik' : 'Contoh: Rawat di Rumah'),
                    _treatmentController,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final studentName = _studentNameController.text.trim();
                        final roomName = _roomController.text.trim();
                        final symptoms = _symptomController.text.trim();
                        final treatment = _treatmentController.text.trim();

                        if (studentName.isEmpty || roomName.isEmpty || symptoms.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Nama, Kamar, dan Gejala harus diisi!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final defaultTreatment = treatment.isEmpty
                            ? (_selectedStatus == 'OBSERVASI'
                                ? 'Kamar (Istirahat)'
                                : (_selectedStatus == 'KLINIK' ? 'Poli Klinik' : 'Rawat di Rumah'))
                            : treatment;

                        setState(() {
                          _searchQuery = '';
                          _searchController.clear();
                          _healthList.insert(0, {
                            'name': studentName,
                            'initials': _getInitials(studentName),
                            'room': roomName,
                            'status': _selectedStatus,
                            'gejala': symptoms,
                            'perawatan': defaultTreatment,
                            'date': _getFormattedDateTime(),
                            'avatarColor': _getRandomAvatarColor(studentName),
                          });
                        });

                        // Clear inputs
                        _studentNameController.clear();
                        _roomController.clear();
                        _symptomController.clear();
                        _treatmentController.clear();
                        _selectedStatus = 'OBSERVASI';

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Laporan kesehatan baru berhasil disimpan!'),
                            backgroundColor: Color(0xFF004D28),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                      label: const Text(
                        'Simpan Laporan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D28),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
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

  Widget _buildDropdownField(String label, IconData icon, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey, size: 20),
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
    // README: Filter real-time menggunakan List.where
    final List<Map<String, dynamic>> filtered = _healthList.where((item) {
      final matchesSearch = item['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'Semua' ||
          item['status'].toString().toUpperCase() ==
              _selectedFilter.toUpperCase();
      return matchesSearch && matchesFilter;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Riwayat Kesehatan Santri',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

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
                      hintText: 'Cari nama santri...',
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

                // Tombol Lapor
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showLaporDialog,
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                    label: const Text(
                      'Lapor Riwayat Baru',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D28),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter chips
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilter == filter;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = filter),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF004D28) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF004D28) : Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // README: Menggunakan ListView.builder untuk render daftar dinamis
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.health_and_safety_outlined, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada data kesehatan ditemukan',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return _buildHealthCard(filtered[index]);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  void _showDetailDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.health_and_safety_outlined, color: Color(0xFF004D28)),
              const SizedBox(width: 8),
              const Text(
                'Detail Riwayat Kesehatan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Nama Santri', item['name']),
              const SizedBox(height: 12),
              _buildDetailRow('Kamar', item['room']),
              const SizedBox(height: 12),
              _buildDetailRow('Gejala', item['gejala']),
              const SizedBox(height: 12),
              _buildDetailRow('Perawatan', item['perawatan']),
              const SizedBox(height: 12),
              _buildDetailRow('Waktu Lapor', item['date']),
              const SizedBox(height: 12),
              _buildDetailRow('Status Kesehatan', item['status']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup', style: TextStyle(color: Color(0xFF004D28), fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildHealthCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
            // Top row: avatar + nama + status badge
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: item['avatarColor'] as Color,
                  child: Text(
                    item['initials'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['room'],
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusBgColor(item['status']),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['status'],
                    style: TextStyle(
                      color: _getStatusColor(item['status']),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 14),

            // Gejala + Perawatan
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GEJALA',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5)),
                      const SizedBox(height: 4),
                      Text(item['gejala'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PERAWATAN',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5)),
                      const SizedBox(height: 4),
                      Text(item['perawatan'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Tanggal + Detail
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 13, color: Colors.grey.shade500),
                    const SizedBox(width: 6),
                    Text(
                      item['date'],
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showDetailDialog(item),
                  child: Row(
                    children: [
                      Text('Detail',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600)),
                      Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade600),
                    ],
                  ),
                ),
              ],
            ),

            // Action buttons depending on status
            if (item['status'] == 'OBSERVASI') ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          item['status'] = 'KLINIK';
                          item['perawatan'] = 'Poli Klinik';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item['name']} dipindahkan ke perawatan Poli Klinik!'),
                            backgroundColor: const Color(0xFF004D28),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1565C0)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Ke Klinik',
                        style: TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          item['status'] = 'SEMBUH';
                          item['perawatan'] = 'Sembuh (Pulih)';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item['name']} dinyatakan Sembuh & Sehat!'),
                            backgroundColor: const Color(0xFF004D28),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D28),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Sembuh',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (item['status'] == 'KLINIK') ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          item['status'] = 'RUMAH';
                          item['perawatan'] = 'Rawat di Rumah';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item['name']} dipulangkan untuk Rawat di Rumah!'),
                            backgroundColor: const Color(0xFFC62828),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFC62828)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Dirawat di Rumah',
                        style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          item['status'] = 'SEMBUH';
                          item['perawatan'] = 'Sembuh (Pulih)';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item['name']} dinyatakan Sembuh & Sehat!'),
                            backgroundColor: const Color(0xFF004D28),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D28),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Sembuh',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (item['status'] == 'RUMAH') ...[
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      item['status'] = 'SEMBUH';
                      item['perawatan'] = 'Sembuh (Pulih)';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['name']} dinyatakan Sembuh & Sehat!'),
                        backgroundColor: const Color(0xFF004D28),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D28),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Dinyatakan Sembuh',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
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
              _buildNavItem(Icons.dashboard_outlined, 'Dashboard', false,
                  () => Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false)),
              _buildNavItem(Icons.people_alt_outlined, 'Visitors', false,
                  () => Navigator.pushNamed(context, '/visit')),
              _buildNavItem(Icons.inventory_2_outlined, 'Logistics', false,
                  () => Navigator.pushNamed(context, '/logistic')),
              _buildNavItem(Icons.health_and_safety_outlined, 'Health', true, () {}),
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
            Icon(icon,
                color: isSelected ? const Color(0xFF004D28) : Colors.grey.shade500,
                size: 22),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected ? const Color(0xFF004D28) : Colors.grey.shade500,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                )),
          ],
        ),
      ),
    );
  }
}
