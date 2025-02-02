import 'package:flutter/material.dart';

import './widgets/listpresensiman1_item_widget.dart';
import '../detail_absensi_manual_ketua_tim_screen/detail_absensi_manual_ketua_tim_screen.dart';
import '../detail_pengajuan_cuti_ketua_tim_screen/detail_pengajuan_cuti_ketua_tim_screen.dart';
import '../detail_pengajuan_kipapp_ketua_tim_screen/detail_pengajuan_kipapp_ketua_tim_screen.dart';
import '../detail_pengajuan_kipapp_ketua_tim_screen_tahun/detail_pengajuan_kipapp_ketua_tim_screen_tahun.dart';
import '../profile_info_screen/profile_info_screen.dart';
import '../notifikasi_ketua_tim_screen/notifikasi_ketua_tim_screen.dart';
import '../../core/app_export.dart';
import '../../services/firebase_service.dart';
import '../../services/excel_service.dart';

class DashboardKetuaTimScreen extends StatefulWidget {
  const DashboardKetuaTimScreen({Key? key}) : super(key: key);

  @override
  _DashboardKetuaTimScreenState createState() =>
      _DashboardKetuaTimScreenState();
}

class _DashboardKetuaTimScreenState extends State<DashboardKetuaTimScreen> {
  String? userName; // Nama pengguna
  String? teamName; // Nama tim
  String? teamId; // ID tim pengguna
  int? roleId;

  List<Map<String, dynamic>> tableData = []; // Data tabel
  bool isLoading = true;
  String activeFilter =
      ''; // Filter permohonan (Presensi Manual, Pengajuan Cuti, KiP APP, atau kosong)

  // Untuk filter waktu (Dropdown)
  List<String> dropdownItemList = [
    "Semua Permohonan",
    "Hari Ini",
    "Minggu Ini",
    "Bulan Ini"
  ];
  int selectedIndex = -1;
  String selectedDropdownItem = "Semua Permohonan";
  final FocusNode dropdownFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initDashboard();
  }

  /// Fungsi inisialisasi data di dalam layar
  Future<void> _initDashboard() async {
    setState(() => isLoading = true);

    // 1) Ambil data user dari service
    final userData = await FirebaseService.getUserData();
    if (userData != null) {
      userName = userData['userName'];
      teamName = userData['teamName'];
      teamId = userData['teamId'];
      roleId = userData['roleId'];
    }

    // 2) Ambil data submissions
    if (teamId != null && teamId!.isNotEmpty) {
      await _fetchTableData(teamId!);
    }

    setState(() => isLoading = false);
  }

  /// Fungsi ambil data submissions (dari service) berdasarkan filter
  Future<void> _fetchTableData(String currentTeamId) async {
    setState(() => isLoading = true);

    final submissions = await FirebaseService.getSubmissionsByTeam(
      teamId: currentTeamId,
      activeFilter: activeFilter,
      selectedDropdownItem: selectedDropdownItem,
    );

    setState(() {
      tableData = submissions;
      isLoading = false;
    });
  }

  /// Handler saat user memilih item dropdown (filter waktu)
  void _onSelectedDropdownItem(String? value) {
    if (value == null) return;
    setState(() {
      selectedDropdownItem = value;
    });
    // Panggil ulang data
    if (teamId != null && teamId!.isNotEmpty) {
      _fetchTableData(teamId!);
    }
  }

  /// Handler saat user klik salah satu filter: Presensi, Cuti, KiP APP
  void _onTapFilter(int index, String filter) {
    setState(() {
      if (selectedIndex == index) {
        // Jika filter yang sama dipilih, batalkan
        selectedIndex = -1;
        activeFilter = '';
      } else {
        // Aktifkan filter baru
        selectedIndex = index;
        activeFilter = filter;
      }
    });
    if (teamId != null && teamId!.isNotEmpty) {
      _fetchTableData(teamId!);
    }
  }

  Future<void> _downloadRekapan() async {
    await ExcelService.downloadRekapan(context, tableData, '');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              // Latar belakang
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 48),
                    decoration: BoxDecoration(
                      color: appTheme.cyan100,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Pilihan filter "Presensi Manual", "Pengajuan Cuti", "KiP APP"
                          _buildListpresensiman(context),
                          const SizedBox(height: 14),

                          // Dropdown filter waktu
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownMenu<String>(
                              initialSelection: dropdownItemList.first,
                              onSelected: _onSelectedDropdownItem,
                              dropdownMenuEntries:
                                  dropdownItemList.map((String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                              focusNode: dropdownFocusNode
                                ..canRequestFocus = false,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Tombol Download Rekapan
                          ElevatedButton.icon(
                            onPressed: _downloadRekapan,
                            icon: const Icon(Icons.download),
                            label: const Text('Download Rekapan'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  const Color.fromARGB(255, 62, 155, 151),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Tabel Data Pengajuan
                          _buildDataTable(),

                          const SizedBox(height: 210),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Bagian header (logo, user info, tombol notifikasi, dsb.)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildColumnprice(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget baris filter: Presensi Manual, Pengajuan Cuti, KiP APP
  Widget _buildListpresensiman(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: List.generate(3, (index) {
            final texts = ["Presensi\nManual", "Pengajuan\nCuti", "KiP APP"];
            final filters = ["Presensi Manual", "Pengajuan Cuti", "KiP APP"];
            final imagePaths = [
              ImageConstant.imgEdit,
              ImageConstant.imgCalendar,
              ImageConstant.imgDownload,
            ];

            return Listpresensiman1ItemWidget(
              text: texts[index],
              imagePath: imagePaths[index],
              isSelected: selectedIndex == index,
              onTap: () => _onTapFilter(index, filters[index]),
              selectedTextColor: const Color(0xFF3E9B97),
            );
          }),
        ),
      ),
    );
  }

  /// Header atas: logo BPS, notifikasi, dan info user
  Widget _buildColumnprice(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 24, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Logo & notifikasi
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLogoBps,
                  height: 28,
                  width: 40,
                  margin: const EdgeInsets.only(left: 26),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 4),
                    child: Text(
                      "GOVERNMENT APPROVAL",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                const Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgMdnotificationsnone,
                  height: 24,
                  width: 26,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NotifikasiKetuaTimScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Card info user
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileInfoScreen()),
                );
              },
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(left: 18),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                  border: Border.all(color: appTheme.gray30001, width: 1),
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgAvatars3dAvatar21,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, ${userName ?? 'Loading...'}",
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            teamName ?? 'Loading...',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    if (roleId == 4)
                      FloatingActionButton.small(
                        onPressed: () {
                          // Pindah ke dashboard pegawai (opsional)
                          Navigator.pushNamed(
                              context, AppRoutes.dashboardPegawaiScreen);
                        },
                        tooltip: "Dashboard Pegawai",
                        child: const Icon(Icons.swap_horiz),
                        backgroundColor: Colors.teal,
                      ),
                    if (roleId == 1 || roleId == 2)
                      FloatingActionButton.small(
                        onPressed: _showDashboardSelectionSheet,
                        tooltip: "Ganti Dashboard",
                        child: const Icon(Icons.swap_horiz),
                        backgroundColor: Colors.teal,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDashboardSelectionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: false, // bisa diatur true jika item banyak
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // tutup bottom sheet
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.dashboardPegawaiScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                    ),
                    child: const Text("Dashboard Pegawai"),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.dashboardPimpinanScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                    ),
                    child: const Text("Dashboard Pimpinan"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Tabel data submission
  Widget _buildDataTable() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: double.infinity,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.white),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        columnSpacing: 16,
        columns: const [
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Nama',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Jenis Pengajuan',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Status',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
        rows: tableData.map((row) {
          return DataRow(
            cells: [
              _buildCenteredCell(row['Nama'] ?? '', row),
              _buildCenteredCell(row['Jenis Pengajuan'] ?? '', row),
              _buildStatusCell(row['Status'] ?? ''),
            ],
          );
        }).toList(),
      ),
    );
  }

  /// Cell dengan teks di tengah + navigasi ke halaman detail
  DataCell _buildCenteredCell(String text, Map<String, dynamic> row) {
    return DataCell(
      Center(
        child: GestureDetector(
          onTap: () => _navigateToDetail(row),
          child: Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  /// Cell khusus untuk Status (warna background)
  DataCell _buildStatusCell(String status) {
    if (status.isEmpty) {
      return const DataCell(SizedBox.shrink());
    }

    // Tentukan warna latar belakang berdasarkan status
    Color statusColor;
    switch (status) {
      case 'Menunggu Persetujuan':
        statusColor = Colors.yellow.shade700;
        break;
      case 'Ditolak oleh Ketua Tim':
      case 'Ditolak oleh Pimpinan':
        statusColor = Colors.red.shade400;
        break;
      case 'Menunggu Persetujuan Pimpinan':
        statusColor = Colors.blue.shade400;
        break;
      case 'Disetujui oleh Pimpinan':
        statusColor = Colors.green.shade400;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataCell(
      Tooltip(
        message: status,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 100),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigasi ke halaman detail (absensi manual, pengajuan cuti, KiP APP)
  void _navigateToDetail(Map<String, dynamic> row) {
    final submissionType = row['Jenis Pengajuan'];
    if (submissionType == "Presensi Manual") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailAbsensiManualKetuaTimScreen(data: row),
        ),
      );
    } else if (submissionType == "Pengajuan Cuti") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPengajuanCutiKetuaTimScreen(data: row),
        ),
      );
    } else if (submissionType == "KiP APP") {
      final kipAppType =
          row['Submission Data']['submission_data']['kipapp_type'];
      if (kipAppType == "Bulanan") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPengajuanKipappKetuaTimScreen(data: row),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPengajuanKipappKetuaTimScreenTahun(data: row),
          ),
        );
      }
    }
  }
}
