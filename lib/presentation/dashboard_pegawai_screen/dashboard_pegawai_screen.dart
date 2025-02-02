import 'package:flutter/material.dart';

import '../profile_info_screen/profile_info_screen.dart';
import '../menu_absen_manual_pegawai_1_screen/menu_absen_manual_pegawai_1_screen.dart';
import '../pengajuan_cuti_pegawai_screen/pengajuan_cuti_pegawai_screen.dart';
import '../kipapp_pegawai_one_screen/kipapp_pegawai_one_screen.dart';
import '../riwayat_screen/riwayat_screen.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';

// Import service
import '../../services/firebase_service.dart';
import 'widgets/listpresensiman_item_widget.dart';

class DashboardPegawaiScreen extends StatefulWidget {
  const DashboardPegawaiScreen({Key? key}) : super(key: key);

  @override
  _DashboardPegawaiScreenState createState() => _DashboardPegawaiScreenState();
}

class _DashboardPegawaiScreenState extends State<DashboardPegawaiScreen> {
  int _selectedIndex = 0;

  // Variabel untuk menyimpan data user
  String? _userName;
  String? _teamName;
  int? _roleId;
  bool _isLoadingUser = true; // status loading data user

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Ambil data user (name, team, role) dari FirebaseService
  Future<void> _loadUserData() async {
    try {
      final userAndTeam = await FirebaseService.getUserData();
      if (userAndTeam == null) {
        setState(() {
          _userName = "User";
          _teamName = " ";
          _roleId = 0;
          _isLoadingUser = false;
        });
        return;
      }

      // Jika ada data, set ke state
      setState(() {
        _userName = userAndTeam['userName'] ?? "User";
        _teamName = userAndTeam['teamName'] ?? "No Team";
        _roleId = userAndTeam['roleId'] ?? 0;
        _isLoadingUser = false;
      });
    } catch (e) {
      debugPrint("Error _loadUserData: $e");
      setState(() => _isLoadingUser = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(child: _buildBody(context)),
              Positioned(
                  top: 0, left: 0, right: 0, child: _buildHeader(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 48),
        decoration: BoxDecoration(
          color: appTheme.cyan100,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(70),
            topRight: Radius.circular(70),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildPresensiList(context),
              const SizedBox(height: 14),
              _buildRiwayatButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBpsLogoRow(),
            SizedBox(height: 12.h),
            _buildUserInfoCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBpsLogoRow() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgLogoBps,
            height: 28.h,
            width: 38.h,
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.h, top: 4.h),
            child: Text(
              "GOVERNMENT APPROVAL",
              style: theme.textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfoCard(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder14,
        border: Border.all(
          color: appTheme.gray30001,
          width: 1.h,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfileRow(context),
          SizedBox(height: 14.h),
          _buildJadwalCard(),
        ],
      ),
    );
  }

  Widget _buildProfileRow(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfileInfoScreen()),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgAvatars3dAvatar21,
              height: 40.h,
              width: 40.h,
              alignment: Alignment.center,
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isLoadingUser
                      ? SizedBox(
                          height: 20.h,
                          child:
                              const CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName == null ? "" : "Hi, $_userName",
                              style: theme.textTheme.titleSmall,
                            ),
                            Text(
                              _teamName ?? "",
                              style: CustomTextStyles.labelMediumErrorContainer,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            if (_roleId == 4)
              FloatingActionButton.small(
                onPressed: () {
                  // Pindah ke dashboard pegawai (opsional)
                  Navigator.pushNamed(
                      context, AppRoutes.dashboardKetuaTimScreen);
                },
                tooltip: "Dashboard Ketua Tim",
                child: const Icon(Icons.swap_horiz),
                backgroundColor: Colors.teal,
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
                          context, AppRoutes.dashboardKetuaTimScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                    ),
                    child: const Text("Dashboard Ketua Tim"),
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

  /// Card yang menampilkan jadwal hari ini
  Widget _buildJadwalCard() {
    // Ambil hari saat ini (1 = Senin, 7 = Minggu)
    DateTime currentTime = DateTime.now();
    int today = currentTime.weekday;

    // Tentukan jam mulai dan selesai berdasarkan hari
    String startTime = "";
    String endTime = "";

    if (today >= 1 && today <= 4) {
      // Senin - Kamis
      startTime = "07:30";
      endTime = "16:00";
    } else if (today == 5) {
      // Jumat
      startTime = "08:00";
      endTime = "16:30";
    } else {
      // Sabtu - Minggu
      startTime = "Libur";
      endTime = "Libur";
    }

    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: appTheme.gray5001,
        borderRadius: BorderRadiusStyle.roundedBorder14,
        border: Border.all(
          color: appTheme.gray30001,
          width: 1.h,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Jadwal Anda Hari Ini",
            style: CustomTextStyles.titleSmallPrimary,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgArrowLeft,
                height: 18.h,
                width: 18.h,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 4.h),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  startTime,
                  style: CustomTextStyles.titleLargeErrorContainer,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgUser,
                height: 24.h,
                width: 24.h,
                margin: EdgeInsets.only(left: 18.h),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowDown,
                height: 18.h,
                width: 20.h,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(left: 22.h, top: 4.h),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  endTime,
                  style: CustomTextStyles.titleLargeErrorContainer,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// Tombol "Riwayat"
  Widget _buildRiwayatButton(BuildContext context) {
    return CustomElevatedButton(
      height: 50.h,
      text: "Riwayat",
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallPrimary,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RiwayatScreen()),
        );
      },
    );
  }

  /// Daftar presensi "Presensi Manual", "Pengajuan Cuti", "KiP App"
  Widget _buildPresensiList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: List.generate(3, (index) {
            final texts = ["Presensi\nManual", "Pengajuan\nCuti", "KiP APP"];
            final imagePaths = [
              ImageConstant.imgEdit,
              ImageConstant.imgCalendar,
              ImageConstant.imgDownload
            ];

            return ListpresensimanItemWidget(
              text: texts[index],
              imagePath: imagePaths[index],
              isSelected: _selectedIndex == index,
              onTap: () => _onPresensiTap(context, index),
              selectedTextColor: const Color(0xFF3E9B97),
            );
          }),
        ),
      ),
    );
  }

  /// Handler untuk navigasi presensi
  void _onPresensiTap(BuildContext context, int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const MenuAbsenManualPegawai1Screen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PengajuanCutiPegawaiScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => KipappPegawaiOneScreen()),
        );
        break;
    }
  }
}
