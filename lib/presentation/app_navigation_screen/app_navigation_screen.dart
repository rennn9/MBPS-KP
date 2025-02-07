import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFFFFFFF),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Text(
                        "App Navigation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 20.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.h),
                      child: Text(
                        "Check your app's UI from the below demo screens of your app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF888888),
                          fontSize: 16.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: Color(0XFF000000),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "SplashScreenOne",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.splashscreenoneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SplashScreenTwo",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.splashscreentwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SplashScreenThree",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.splashscreenthreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SplashScreenFour",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.splashscreenfourScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SplashScreenFive",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.splashscreenfiveScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Signup Up",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signupUpScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Forgot Password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.forgotPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Dashboard Admin",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.dashboardAdminScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Dashboard Pegawai",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.dashboardPegawaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Profile Info",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.profileInfoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Riwayat",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.riwayatScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail riwayat(Pegawai)",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.detailRiwayatPegawaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail riwayat(Pegawai) One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.detailRiwayatPegawaiOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail riwayat(Pegawai) Two",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.detailRiwayatPegawaiTwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail riwayat(Pegawai) Three",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailRiwayatPegawaiThreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail riwayat KipAPP(Pegawai)",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailRiwayatKipappPegawaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail riwayat(Pegawai) Four",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailRiwayatPegawaiFourScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pengajuan Cuti(pegawai)",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.pengajuanCutiPegawaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pengajuan Cuti Setengah Hari(pegawai)",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.pengajuanCutiSetengahHariPegawaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Menu Absen Manual(Pegawai)(1)",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.menuAbsenManualPegawai1Screen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Menu Absen Manual(Pegawai)(2)",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.menuAbsenManualPegawai2Screen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "KipAPP (pegawai)",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.kipappPegawaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "KipAPP (pegawai) One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.kipappPegawaiOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "KipAPP (pegawai) Two",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.kipappPegawaiTwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Submit Berhasil",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.submitBerhasilScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Dashboard Ketua Tim",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.dashboardKetuaTimScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Profile Info(Ketua Tim)",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.profileInfoKetuaTimScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail Pengajuan Cuti Ketua TIM",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailPengajuanCutiKetuaTimScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail Absensi Manual(Ketua TIM)",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailAbsensiManualKetuaTimScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail Pengajuan KipAPP(Ketua Tim)",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailPengajuanKipappKetuaTimScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notifikasi (Ketua Tim)",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.notifikasiKetuaTimScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Dashboard Pimpinan",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.dashboardPimpinanScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail Pengajuan Cuti (Pimpinan)",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailPengajuanCutiPimpinanScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail Absensi Manual (Pimpinan)",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailAbsensiManualPimpinanScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Detail Pengajuan KipAPP(Pimpinan)",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.detailPengajuanKipappPimpinanScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenTitle(BuildContext context,
      {required String screenTitle, required VoidCallback onTapScreenTitle}) {
    return InkWell(
      onTap: onTapScreenTitle,
      child: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 20.h,
          right: 20.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                screenTitle,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.fSize,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  color: Color(0XFF000000),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15.h,
            ),
          ],
        ),
      ),
    );
  }

  onTapScreenTitle(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
