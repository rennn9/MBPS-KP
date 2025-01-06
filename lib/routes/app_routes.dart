import 'package:flutter/material.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/dashboard_ketua_tim_screen/dashboard_ketua_tim_screen.dart';
import '../presentation/dashboard_pegawai_screen/dashboard_pegawai_screen.dart';
import '../presentation/dashboard_pimpinan_screen/dashboard_pimpinan_screen.dart';
import '../presentation/detail_absensi_manual_ketua_tim_screen/detail_absensi_manual_ketua_tim_screen.dart';
import '../presentation/detail_absensi_manual_pimpinan_screen/detail_absensi_manual_pimpinan_screen.dart';
import '../presentation/detail_pengajuan_cuti_ketua_tim_screen/detail_pengajuan_cuti_ketua_tim_screen.dart';
import '../presentation/detail_pengajuan_cuti_pimpinan_screen/detail_pengajuan_cuti_pimpinan_screen.dart';
import '../presentation/detail_pengajuan_kipapp_ketua_tim_screen/detail_pengajuan_kipapp_ketua_tim_screen.dart';
import '../presentation/detail_pengajuan_kipapp_pimpinan_screen/detail_pengajuan_kipapp_pimpinan_screen.dart';
import '../presentation/detail_riwayat_kipapp_pegawai_screen/detail_riwayat_kipapp_pegawai_screen.dart';
import '../presentation/detail_riwayat_pegawai_four_screen/detail_riwayat_pegawai_four_screen.dart';
import '../presentation/detail_riwayat_pegawai_one_screen/detail_riwayat_pegawai_one_screen.dart';
import '../presentation/detail_riwayat_pegawai_screen/detail_riwayat_pegawai_screen.dart';
import '../presentation/detail_riwayat_pegawai_three_screen/detail_riwayat_pegawai_three_screen.dart';
import '../presentation/detail_riwayat_pegawai_two_screen/detail_riwayat_pegawai_two_screen.dart';
import '../presentation/kipapp_pegawai_one_screen/kipapp_pegawai_one_screen.dart';
import '../presentation/kipapp_pegawai_screen/kipapp_pegawai_screen.dart';
import '../presentation/kipapp_pegawai_two_screen/kipapp_pegawai_two_screen.dart';
import '../presentation/menu_absen_manual_pegawai_1_screen/menu_absen_manual_pegawai_1_screen.dart';
import '../presentation/notifikasi_ketua_tim_screen/notifikasi_ketua_tim_screen.dart';
import '../presentation/notifikasi_pimpinan_screen/notifikasi_pimpinan_screen.dart';
import '../presentation/notifikasi_tidak_ada_screen/notifikasi_tidak_ada_screen.dart';
import '../presentation/pengajuan_cuti_pegawai_screen/pengajuan_cuti_pegawai_screen.dart';
import '../presentation/pengajuan_cuti_setengah_hari_pegawai_screen/pengajuan_cuti_setengah_hari_pegawai_screen.dart';
import '../presentation/profile_info_ketua_tim_screen/profile_info_ketua_tim_screen.dart';
import '../presentation/profile_info_pimpinan_screen/profile_info_pimpinan_screen.dart';
import '../presentation/profile_info_screen/profile_info_screen.dart';
import '../presentation/riwayat_screen/riwayat_screen.dart';
import '../presentation/signup_up_screen/signup_up_screen.dart';
import '../presentation/splashscreenfive_screen/splashscreenfive_screen.dart';
import '../presentation/splashscreenfour_screen/splashscreenfour_screen.dart';
import '../presentation/splashscreenone_screen/splashscreenone_screen.dart';
import '../presentation/splashscreenthree_screen/splashscreenthree_screen.dart';
import '../presentation/splashscreentwo_screen/splashscreentwo_screen.dart';
import '../presentation/submit_berhasil_screen/submit_berhasil_screen.dart';
import '../presentation/tampilan_error_screen/tampilan_error_screen.dart';

// ignore_for_file: must_be_immutable

class AppRoutes {
  static const String splashscreenoneScreen = '/splashscreenone_screen';
  static const String splashscreentwoScreen = '/splashscreentwo_screen';
  static const String splashscreenthreeScreen = '/splashscreenthree_screen';
  static const String splashscreenfourScreen = '/splashscreenfour_screen';
  static const String splashscreenfiveScreen = '/splashscreenfive_screen';
  static const String signupUpScreen = '/signup_up_screen';
  static const String dashboardPegawaiScreen = '/dashboard_pegawai_screen';
  static const String profileInfoScreen = '/profile_info_screen';
  static const String riwayatScreen = '/riwayat_screen';
  static const String detailRiwayatPegawaiScreen =
      '/detail_riwayat_pegawai_screen';
  static const String detailRiwayatPegawaiOneScreen =
      '/detail_riwayat_pegawai_one_screen';
  static const String detailRiwayatPegawaiTwoScreen =
      '/detail_riwayat_pegawai_two_screen';
  static const String detailRiwayatPegawaiThreeScreen =
      '/detail_riwayat_pegawai_three_screen';
  static const String detailRiwayatKipappPegawaiScreen =
      '/detail_riwayat_kipapp_pegawai_screen';
  static const String detailRiwayatPegawaiFourScreen =
      '/detail_riwayat_pegawai_four_screen';
  static const String pengajuanCutiPegawaiScreen =
      '/pengajuan_cuti_pegawai_screen';
  static const String pengajuanCutiSetengahHariPegawaiScreen =
      '/pengajuan_cuti_setengah_hari_pegawai_screen';
  static const String menuAbsenManualPegawai1Screen =
      '/menu_absen_manual_pegawai_1_screen';
  static const String menuAbsenManualPegawai2Screen =
      '/menu_absen_manual_pegawai_2_screen';
  static const String kipappPegawaiScreen = '/kipapp_pegawai_screen';
  static const String kipappPegawaiOneScreen = '/kipapp_pegawai_one_screen';
  static const String kipappPegawaiTwoScreen = '/kipapp_pegawai_two_screen';
  static const String submitBerhasilScreen = '/submit_berhasil_screen';
  static const String dashboardKetuaTimScreen = '/dashboard_ketua_tim_screen';
  static const String profileInfoKetuaTimScreen =
      '/profile_info_ketua_tim_screen';
  static const String detailPengajuanCutiKetuaTimScreen =
      '/detail_pengajuan_cuti_ketua_tim_screen';
  static const String detailAbsensiManualKetuaTimScreen =
      '/detail_absensi_manual_ketua_tim_screen';
  static const String detailPengajuanKipappKetuaTimScreen =
      '/detail_pengajuan_kipapp_ketua_tim_screen';
  static const String notifikasiKetuaTimScreen = '/notifikasi_ketua_tim_screen';
  static const String dashboardPimpinanScreen = '/dashboard_pimpinan_screen';
  static const String detailPengajuanCutiPimpinanScreen =
      '/detail_pengajuan_cuti_pimpinan_screen';
  static const String detailAbsensiManualPimpinanScreen =
      '/detail_absensi_manual_pimpinan_screen';
  static const String detailPengajuanKipappPimpinanScreen =
      '/detail_pengajuan_kipapp_pimpinan_screen';
  static const String notifikasiPimpinanScreen = '/notifikasi_pimpinan_screen';
  static const String profileInfoPimpinanScreen =
      '/profile_info_pimpinan_screen';
  static const String notifikasiTidakAdaScreen = '/notifikasi_tidak_ada_screen';
  static const String tampilanErrorScreen = '/tampilan_error_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    splashscreenoneScreen: (context) => SplashscreenoneScreen(),
    splashscreentwoScreen: (context) => SplashscreentwoScreen(),
    splashscreenthreeScreen: (context) => SplashscreenthreeScreen(),
    splashscreenfourScreen: (context) => SplashscreenfourScreen(),
    splashscreenfiveScreen: (context) => SplashscreenfiveScreen(),
    signupUpScreen: (context) => SignupUpScreen(),
    dashboardPegawaiScreen: (context) => DashboardPegawaiScreen(),
    profileInfoScreen: (context) => ProfileInfoScreen(),
    riwayatScreen: (context) => RiwayatScreen(),
    detailRiwayatPegawaiScreen: (context) => DetailRiwayatPegawaiScreen(),
    detailRiwayatPegawaiOneScreen: (context) => DetailRiwayatPegawaiOneScreen(),
    detailRiwayatPegawaiTwoScreen: (context) => DetailRiwayatPegawaiTwoScreen(),
    detailRiwayatPegawaiThreeScreen: (context) =>
        DetailRiwayatPegawaiThreeScreen(),
    detailRiwayatKipappPegawaiScreen: (context) =>
        DetailRiwayatKipappPegawaiScreen(),
    detailRiwayatPegawaiFourScreen: (context) =>
        DetailRiwayatPegawaiFourScreen(),
    pengajuanCutiPegawaiScreen: (context) => PengajuanCutiPegawaiScreen(),
    pengajuanCutiSetengahHariPegawaiScreen: (context) =>
        PengajuanCutiSetengahHariPegawaiScreen(),
    menuAbsenManualPegawai1Screen: (context) => MenuAbsenManualPegawai1Screen(),
    kipappPegawaiScreen: (context) => KipappPegawaiScreen(),
    kipappPegawaiOneScreen: (context) => KipappPegawaiOneScreen(),
    kipappPegawaiTwoScreen: (context) => KipappPegawaiTwoScreen(),
    submitBerhasilScreen: (context) => SubmitBerhasilScreen(),
    dashboardKetuaTimScreen: (context) => DashboardKetuaTimScreen(),
    profileInfoKetuaTimScreen: (context) => ProfileInfoKetuaTimScreen(),
    detailPengajuanCutiKetuaTimScreen: (context) =>
        DetailPengajuanCutiKetuaTimScreen(),
    detailAbsensiManualKetuaTimScreen: (context) =>
        DetailAbsensiManualKetuaTimScreen(),
    detailPengajuanKipappKetuaTimScreen: (context) =>
        DetailPengajuanKipappKetuaTimScreen(),
    notifikasiKetuaTimScreen: (context) => NotifikasiKetuaTimScreen(),
    dashboardPimpinanScreen: (context) => DashboardPimpinanScreen(),
    detailPengajuanCutiPimpinanScreen: (context) =>
        DetailPengajuanCutiPimpinanScreen(),
    detailAbsensiManualPimpinanScreen: (context) =>
        DetailAbsensiManualPimpinanScreen(),
    detailPengajuanKipappPimpinanScreen: (context) =>
        DetailPengajuanKipappPimpinanScreen(),
    notifikasiPimpinanScreen: (context) => NotifikasiPimpinanScreen(),
    profileInfoPimpinanScreen: (context) => ProfileInfoPimpinanScreen(),
    notifikasiTidakAdaScreen: (context) => NotifikasiTidakAdaScreen(),
    tampilanErrorScreen: (context) => TampilanErrorScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => SplashscreenoneScreen()
  };
}
