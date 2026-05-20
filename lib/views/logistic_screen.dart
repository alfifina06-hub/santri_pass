import 'package:flutter/material.dart';

class LogisticScreen extends StatefulWidget {
  const LogisticScreen({super.key});

  @override
  State<LogisticScreen> createState() => _LogisticScreenState();
}

class _LogisticScreenState extends State<LogisticScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // README: Menggunakan List<Map> sebagai sumber data
  final List<Map<String, dynamic>> _titipanList = [
    {
      'type': 'Uang Saku',
      'typeIcon': Icons.wallet_outlined,
      'name': 'Ahmad Zulkarnain',
      'amount': 'Rp 500.000',
      'from': 'Ibu Fatimah (Wali)',
      'time': '10:45 AM',
      'status': 'masuk',   // 'masuk' or 'belum_diambil'
      'statusLabel': null,
    },
    {
      'type': 'Paket Barang',
      'typeIcon': Icons.inventory_2_outlined,
      'name': 'Muhammad Fatih',
      'description': '"Box plastik berisi pakaian & perlengkapan mandi"',
      'courier': 'J&T Express',
      'time': '09:12 AM',
      'status': 'masuk',
      'statusLabel': null,
    },
    {
      'type': 'Uang Saku',
      'typeIcon': Icons.wallet_outlined,
      'name': 'Siti Aminah',
      'amount': 'Rp 150.000',
      'from': 'Bpk. Andi (Wali)',
      'time': '08:30 AM',
      'status': 'belum_diambil',
      'statusLabel': 'Terkirim',
    },
    {
      'type': 'Paket Barang',
      'typeIcon': Icons.inventory_2_outlined,
      'name': 'Ridho Pratama',
      'description': '"Buku pelajaran & alat tulis semester baru"',
      'courier': 'SiCepat',
      'time': '07:55 AM',
      'status': 'belum_diambil',
      'statusLabel': 'Menunggu',
    },
    {
      'type': 'Uang Saku',
      'typeIcon': Icons.wallet_outlined,
      'name': 'Hafizh Syahputra',
      'amount': 'Rp 200.000',
      'from': 'Ibu Rahayu (Wali)',
      'time': '07:30 AM',
      'status': 'masuk',
      'statusLabel': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showAddTitipanDialog() {
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
                'Catat Titipan Baru',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildInputField('Nama Santri', Icons.person_outline, 'Contoh: Ahmad Zulkarnain'),
              const SizedBox(height: 12),
              _buildInputField('Jenis Titipan', Icons.category_outlined, 'Uang Saku / Paket Barang'),
              const SizedBox(height: 12),
              _buildInputField('Dari (Nama Wali)', Icons.people_outline, 'Contoh: Ibu Fatimah'),
              const SizedBox(height: 12),
              _buildInputField('Jumlah / Keterangan', Icons.notes_outlined, 'Contoh: Rp 500.000 atau deskripsi barang'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                  label: const Text(
                    'Simpan Titipan',
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
  }

  Widget _buildInputField(String label, IconData icon, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey, size: 20),
            hintText: hint,
            hintStyle:
                TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // README: Filter menggunakan List.where (real-time search)
    final String currentTab =
        _tabController.index == 0 ? 'masuk' : 'belum_diambil';

    final List<Map<String, dynamic>> filtered = _titipanList.where((item) {
      final matchesTab = item['status'] == currentTab;
      final matchesSearch = item['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF004D28),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
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
              child: const Icon(Icons.person,
                  color: Color(0xFF004D28), size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Titipan Uang & Barang',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Manajemen logistik dan titipan wali santri.',
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),

                // Tab Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    onTap: (_) => setState(() {}),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: const Color(0xFF004D28),
                    unselectedLabelColor: Colors.grey.shade600,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                    unselectedLabelStyle:
                        const TextStyle(fontSize: 13),
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Titipan Masuk'),
                      Tab(text: 'Belum Diambil'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Button Catat Titipan Baru
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showAddTitipanDialog,
                    icon: const Icon(Icons.add_circle_outline,
                        color: Colors.white),
                    label: const Text(
                      'Catat Titipan Baru',
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
                const SizedBox(height: 16),

                // Search Bar + Filter icon
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border:
                              Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (v) =>
                              setState(() => _searchQuery = v),
                          decoration: InputDecoration(
                            icon: Icon(Icons.search,
                                color: Colors.grey.shade400),
                            hintText: 'Cari nama santri...',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14),
                            border: InputBorder.none,
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear,
                                        color: Colors.grey),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(
                                          () => _searchQuery = '');
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Icon(Icons.tune_outlined,
                          color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // README: Menggunakan ListView.builder untuk render daftar
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada titipan ditemukan',
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return _buildTitipanCard(filtered[index]);
                    },
                  ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildTitipanCard(Map<String, dynamic> item) {
    final bool isUang = item['type'] == 'Uang Saku';
    final bool hasStatusLabel = item['statusLabel'] != null;

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
            // Top row: type badge + time (+ status label if any)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item['typeIcon'],
                            size: 14,
                            color: const Color(0xFF004D28),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item['type'],
                            style: const TextStyle(
                              color: Color(0xFF004D28),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      item['time'],
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade500),
                    ),
                    if (hasStatusLabel) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item['statusLabel'],
                          style: const TextStyle(
                            color: Color(0xFF004D28),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Name
            Text(
              item['name'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),

            // Amount or description
            if (isUang && item['amount'] != null) ...[
              Text(
                item['amount'],
                style: const TextStyle(
                  color: Color(0xFF004D28),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.person_outline,
                      size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    'Dari: ${item['from']}',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ] else if (!isUang && item['description'] != null) ...[
              Text(
                item['description'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.local_shipping_outlined,
                      size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    'Kurir: ${item['courier']}',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],

            // Action buttons (only for cards without statusLabel)
            if (!hasStatusLabel) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Detail',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D28),
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isUang ? 'Konfirmasi' : 'Serahkan',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
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
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                Icons.dashboard_outlined,
                'Dashboard',
                false,
                () => Navigator.pushNamedAndRemoveUntil(
                    context, '/dashboard', (route) => false),
              ),
              _buildNavItem(
                Icons.people_alt_outlined,
                'Visitors',
                false,
                () => Navigator.pushNamed(context, '/visit'),
              ),
              _buildNavItem(
                Icons.inventory_2_outlined,
                'Logistics',
                true,
                () {},
              ),
              _buildNavItem(
                Icons.health_and_safety_outlined,
                'Health',
                false,
                () => Navigator.pushNamed(context, '/health'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green.shade100
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF004D28)
                  : Colors.grey.shade500,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? const Color(0xFF004D28)
                    : Colors.grey.shade500,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
