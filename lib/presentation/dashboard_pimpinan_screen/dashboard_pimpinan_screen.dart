import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import './widgets/expandablelists_item_widget.dart';
import '../profile_info_screen/profile_info_screen.dart';
import '../notifikasi_pimpinan_screen/notifikasi_pimpinan_screen.dart';
import '../../core/app_export.dart';
import '../dashboard_ketua_tim_screen/widgets/listpresensiman1_item_widget.dart';
import '../../services/firebase_service.dart';

class DashboardPimpinanScreen extends StatefulWidget {
  const DashboardPimpinanScreen({Key? key}) : super(key: key);

  @override
  _DashboardPimpinanScreenState createState() =>
      _DashboardPimpinanScreenState();
}

class _DashboardPimpinanScreenState extends State<DashboardPimpinanScreen> {
  String? _userName;
  int? _roleId;
  String? _profileImage;
  bool _isLoadingData = true;

  /// Data submissions yang sudah dikelompokkan per tim:
  List<Map<String, dynamic>> expandableData = [];

  /// Filter untuk "Presensi Manual", "Pengajuan Cuti", "KiP APP", dsb.
  String activeFilter = '';

  /// Filter untuk waktu: "Semua Permohonan", "Hari Ini", "Minggu Ini", "Bulan Ini"
  List<String> dropdownItemList = [
    "Semua Permohonan",
    "Hari Ini",
    "Minggu Ini",
    "Bulan Ini"
  ];
  String selectedDropdownItem = "Semua Permohonan";
  final FocusNode dropdownFocusNode = FocusNode();

  /// Menandai filter "Presensi Manual", "Pengajuan Cuti", atau "KiP APP"
  /// di tampilan horizontal (Listpresensiman1ItemWidget).
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _initScreen();
  }

  /// Inisialisasi layar (load data user + submissions)
  Future<void> _initScreen() async {
    // Ambil data user
    final userData = await FirebaseService.getUserData();
    if (userData != null) {
      _userName = userData['userName'] ?? "User";
      _roleId = userData['roleId'];
      _profileImage = AuthService.getProfilePicturePath(userData['gender']);
    }

    // Load data submissions
    await _fetchSubmissions();
  }

  /// Memanggil service untuk ambil data submissions (yang dikelompokkan per tim)
  Future<void> _fetchSubmissions() async {
    setState(() => _isLoadingData = true);

    // Memanggil function getSubmissionsGroupedByTeam dari firebase_service
    final result = await FirebaseService.getSubmissionsGroupedByTeam(
      activeFilter: activeFilter,
      selectedDropdownItem: selectedDropdownItem,
    );

    final List<Map<String, dynamic>> tempData = [];
    result.forEach((label, dataList) {
      tempData.add({
        "label": label,
        "tableData": dataList,
      });
    });

    setState(() {
      expandableData = tempData;
      _isLoadingData = false;
    });
  }

  /// Handler: jika user memilih salah satu dropdown filter waktu
  void _onSelectedDropdownItem(String? value) {
    if (value == null) return;
    setState(() {
      selectedDropdownItem = value;
    });
    _fetchSubmissions(); // Refresh data
  }

  /// Handler: jika user klik salah satu filter: "Presensi Manual", "Pengajuan Cuti", "KiP APP"
  void _onFilterItemTap(int index, String filter) {
    setState(() {
      if (selectedIndex == index) {
        // Jika filter yang sama dipilih, batalkan
        selectedIndex = -1;
        activeFilter = '';
      } else {
        selectedIndex = index;
        activeFilter = filter;
      }
    });
    _fetchSubmissions();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
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
                          // Filter bar "Presensi Manual", "Pengajuan Cuti", "KiP APP"
                          _buildListpresensiman(context),
                          const SizedBox(height: 14),

                          // Dropdown untuk filter waktu
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
                                  value: value,
                                  label: value,
                                );
                              }).toList(),
                              focusNode: dropdownFocusNode
                                ..canRequestFocus = false,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Loading / menampilkan data
                          if (_isLoadingData)
                            const Center(child: CircularProgressIndicator())
                          else
                            Column(
                              children: expandableData.map((data) {
                                // Masing-masing tim
                                return Column(
                                  children: [
                                    ExpandablelistsItemWidget(
                                      tableData: data["tableData"],
                                      label: data["label"],
                                      onTapRowone: () {
                                        // Aksi jika perlu
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Bagian Header: Logo, notifikasi, dan info user
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildHeader(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Header atas: menampilkan logo BPS, notifikasi, data user
  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 24, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLogoBps,
                  height: 28,
                  width: 40,
                  margin: const EdgeInsets.only(left: 26),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: Text(
                    "GOVERNMENT APPROVAL",
                    style: theme.textTheme.titleSmall,
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
                        builder: (context) => NotifikasiPimpinanScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Buka Profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileInfoScreen()),
                );
              },
              child: Container(
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
                      imagePath: _profileImage,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Hi, ${_userName ?? 'Loading...'}",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    if (_roleId == 1 || _roleId == 2)
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

  /// Fungsi menampilkan bottom sheet: Pilih Dashboard Ketua Tim atau Pimpinan
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
                          context, AppRoutes.dashboardKetuaTimScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                    ),
                    child: const Text("Dashboard Ketua Tim"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Filter bar: "Presensi Manual", "Pengajuan Cuti", "KiP APP"
  Widget _buildListpresensiman(BuildContext context) {
    final texts = ["Presensi\nManual", "Pengajuan\nCuti", "KiP APP"];
    final filters = ["Presensi Manual", "Pengajuan Cuti", "KiP APP"];
    final imagePaths = [
      ImageConstant.imgEdit,
      ImageConstant.imgCalendar,
      ImageConstant.imgDownload,
    ];

    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: List.generate(3, (index) {
            return Listpresensiman1ItemWidget(
              text: texts[index],
              imagePath: imagePaths[index],
              isSelected: selectedIndex == index,
              onTap: () => _onFilterItemTap(index, filters[index]),
              selectedTextColor: const Color(0xFF3E9B97),
            );
          }),
        ),
      ),
    );
  }
}
