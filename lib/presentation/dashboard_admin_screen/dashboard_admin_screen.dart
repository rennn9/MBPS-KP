import 'package:flutter/material.dart';
import 'package:projectbps/services/auth_service.dart';

import '../profile_info_screen/profile_info_screen.dart';
import '../../core/app_export.dart';
import '../../services/firebase_service.dart';

class DashboardAdminScreen extends StatefulWidget {
  const DashboardAdminScreen({Key? key}) : super(key: key);

  @override
  _DashboardAdminScreenState createState() => _DashboardAdminScreenState();
}

class _DashboardAdminScreenState extends State<DashboardAdminScreen> {
  String? userName;
  String? profileImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDashboard();
  }

  /// Ambil data admin
  Future<void> _initDashboard() async {
    setState(() => isLoading = true);

    // Ambil data user admin dari FirebaseService
    final userData = await FirebaseService.getUserData();
    if (userData != null) {
      userName = userData['userName'];
      profileImage = AuthService.getProfilePicturePath(userData['gender']);
    }

    setState(() => isLoading = false);
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
                      child: _buildMainContent(context),
                    ),
                  ),
                ),
              ),

              // Header (logo, user info, dsb.)
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

  /// Bagian konten utama
  Widget _buildMainContent(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Silakan pilih dashboard:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // 1) Tombol Dashboard Pegawai
        _buildDashboardOption(
          title: "Dashboard Pegawai",
          onTap: () {
            // Langsung ke Dashboard Pegawai
            Navigator.pushNamed(context, AppRoutes.dashboardPegawaiScreen);
          },
        ),
        const SizedBox(height: 10),

        // 2) Tombol Dashboard Ketua Tim
        _buildDashboardOption(
          title: "Dashboard Ketua Tim",
          onTap: () {
            // Langsung ke Dashboard Ketua Tim
            Navigator.pushNamed(context, AppRoutes.dashboardKetuaTimScreen);
          },
        ),
        const SizedBox(height: 10),

        // 3) Tombol Dashboard Pimpinan
        _buildDashboardOption(
          title: "Dashboard Pimpinan",
          onTap: () {
            // Langsung ke Dashboard Pimpinan
            Navigator.pushNamed(context, AppRoutes.dashboardPimpinanScreen);
          },
        ),
      ],
    );
  }

  /// Tombol satu baris, misal ElevatedButton
  Widget _buildDashboardOption({
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
        ),
        onPressed: onTap,
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  /// Header atas: logo BPS, notifikasi, info user
  Widget _buildHeader(BuildContext context) {
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
              ],
            ),
            const SizedBox(height: 16),

            // Card info user admin
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
                      imagePath: profileImage,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, ${userName ?? ''}",
                            style: theme.textTheme.titleSmall,
                          ),
                          const Text(
                            "Administrator",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
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
    );
  }
}
