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

  // Controllers for adding a new deposit
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _fromOrCourierController = TextEditingController();
  final TextEditingController _amountOrDescController = TextEditingController();
  String _selectedType = 'Uang Saku';

  // README: Menggunakan List<Map> sebagai sumber data
  final List<Map<String, dynamic>> _titipanList = [
    {
      'type': 'Uang Saku',
      'typeIcon': Icons.wallet_outlined,
      'name': 'Ahmad Zulkarnain',
      'amount': 'Rp 500.000',
      'from': 'Ibu Fatimah (Wali)',
      'time': '10:45 AM',
      'status': 'masuk',   // 'masuk', 'belum_diambil', or 'sudah_diambil'
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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _studentNameController.dispose();
    _fromOrCourierController.dispose();
    _amountOrDescController.dispose();
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

  void _showDetailDialog(Map<String, dynamic> item) {
    final bool isUang = item['type'] == 'Uang Saku';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(item['typeIcon'] as IconData, color: const Color(0xFF004D28)),
              const SizedBox(width: 8),
              Text(
                'Detail ${item['type']}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Nama Santri', item['name']),
              const SizedBox(height: 12),
              if (isUang) ...[
                _buildDetailRow('Jumlah', item['amount'] ?? '-'),
                const SizedBox(height: 12),
                _buildDetailRow('Dari (Wali)', item['from'] ?? '-'),
              ] else ...[
                _buildDetailRow('Keterangan', item['description'] ?? '-'),
                const SizedBox(height: 12),
                _buildDetailRow('Kurir', item['courier'] ?? '-'),
              ],
              const SizedBox(height: 12),
              _buildDetailRow('Waktu Catat', item['time']),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Status', 
                item['status'] == 'masuk' 
                    ? 'DAFTAR TITIPAN (MASUK)' 
                    : (item['status'] == 'belum_diambil' ? 'BELUM DIAMBIL' : 'SUDAH DIAMBIL')
              ),
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

  String _formatAmountString(String amount) {
    final digits = amount.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return amount;
    final numVal = int.tryParse(digits);
    if (numVal == null) return amount;
    final str = numVal.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  void _showAddTitipanDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final isUang = _selectedType == 'Uang Saku';
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
                  _buildInputField('Nama Santri', Icons.person_outline, 'Contoh: Ahmad Zulkarnain', _studentNameController),
                  const SizedBox(height: 12),
                  _buildDropdownField(
                    'Jenis Titipan',
                    Icons.category_outlined,
                    _selectedType,
                    ['Uang Saku', 'Paket Barang'],
                    (val) {
                      if (val != null) {
                        setModalState(() {
                          _selectedType = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildInputField(
                    isUang ? 'Dari (Nama Wali)' : 'Kurir / Pengirim',
                    isUang ? Icons.people_outline : Icons.local_shipping_outlined,
                    isUang ? 'Contoh: Ibu Fatimah' : 'Contoh: J&T Express / Bpk. Andi',
                    _fromOrCourierController,
                  ),
                  const SizedBox(height: 12),
                  _buildInputField(
                    isUang ? 'Jumlah Uang' : 'Keterangan Barang',
                    isUang ? Icons.wallet_outlined : Icons.notes_outlined,
                    isUang ? 'Contoh: 500000' : 'Contoh: Box plastik berisi pakaian',
                    _amountOrDescController,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final studentName = _studentNameController.text.trim();
                        final fromOrCourier = _fromOrCourierController.text.trim();
                        final amountOrDesc = _amountOrDescController.text.trim();

                        if (studentName.isEmpty || fromOrCourier.isEmpty || amountOrDesc.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Semua field harus diisi!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        setState(() {
                          _searchQuery = '';
                          _searchController.clear();
                          if (_selectedType == 'Uang Saku') {
                            final String formattedAmount = amountOrDesc.startsWith('Rp') 
                                ? amountOrDesc 
                                : 'Rp ${_formatAmountString(amountOrDesc)}';
                            
                            _titipanList.insert(0, {
                              'type': 'Uang Saku',
                              'typeIcon': Icons.wallet_outlined,
                              'name': studentName,
                              'amount': formattedAmount,
                              'from': '$fromOrCourier (Wali)',
                              'time': _getFormattedTime(),
                              'status': 'masuk',
                              'statusLabel': null,
                            });
                          } else {
                            _titipanList.insert(0, {
                              'type': 'Paket Barang',
                              'typeIcon': Icons.inventory_2_outlined,
                              'name': studentName,
                              'description': '"$amountOrDesc"',
                              'courier': fromOrCourier,
                              'time': _getFormattedTime(),
                              'status': 'masuk',
                              'statusLabel': null,
                            });
                          }
                        });

                        // Clear inputs
                        _studentNameController.clear();
                        _fromOrCourierController.clear();
                        _amountOrDescController.clear();
                        _selectedType = 'Uang Saku';

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Titipan baru berhasil dicatat!'),
                            backgroundColor: Color(0xFF004D28),
                          ),
                        );
                      },
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
      },
    );
  }

  Widget _buildInputField(String label, IconData icon, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
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
    // README: Filter menggunakan List.where (real-time search)
    final String currentTab;
    if (_tabController.index == 0) {
      currentTab = 'masuk';
    } else if (_tabController.index == 1) {
      currentTab = 'belum_diambil';
    } else {
      currentTab = 'sudah_diambil';
    }

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
                      Tab(text: 'Daftar Titipan'),
                      Tab(text: 'Belum Diambil'),
                      Tab(text: 'Sudah Diambil'),
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
                            item['typeIcon'] as IconData,
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
                          color: item['statusLabel'] == 'Menunggu'
                              ? Colors.orange.shade100
                              : (item['statusLabel'] == 'Terkirim'
                                  ? Colors.blue.shade100
                                  : Colors.green.shade100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item['statusLabel'],
                          style: TextStyle(
                            color: item['statusLabel'] == 'Menunggu'
                                ? Colors.orange.shade800
                                : (item['statusLabel'] == 'Terkirim'
                                    ? Colors.blue.shade800
                                    : const Color(0xFF004D28)),
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

            // Action buttons depending on status
            if (item['status'] == 'masuk') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _showDetailDialog(item);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
                      onPressed: () {
                        setState(() {
                          item['status'] = 'belum_diambil';
                          item['statusLabel'] = isUang ? 'Terkirim' : 'Menunggu';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isUang
                                ? 'Uang saku berhasil dikonfirmasi!'
                                : 'Paket barang siap diserahkan!'),
                            backgroundColor: const Color(0xFF004D28),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D28),
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
            ] else if (item['status'] == 'belum_diambil') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _showDetailDialog(item);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
                      onPressed: () {
                        setState(() {
                          item['status'] = 'sudah_diambil';
                          item['statusLabel'] = 'Diambil';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Titipan berhasil ditandai sudah diambil oleh santri!'),
                            backgroundColor: Color(0xFF004D28),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D28),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Ambil Titipan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (item['status'] == 'sudah_diambil') ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showDetailDialog(item);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
