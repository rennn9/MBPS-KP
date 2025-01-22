import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import untuk memanipulasi tanggal dan waktu

import '../../core/app_export.dart';
import 'widgets/listpresensiman_item_widget.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../profile_info_screen/profile_info_screen.dart';
import '../menu_absen_manual_pegawai_1_screen/menu_absen_manual_pegawai_1_screen.dart';
import '../pengajuan_cuti_pegawai_screen/pengajuan_cuti_pegawai_screen.dart';
import '../kipapp_pegawai_one_screen/kipapp_pegawai_one_screen.dart';
import '../riwayat_screen/riwayat_screen.dart';

class DashboardPegawaiScreen extends StatefulWidget {
  DashboardPegawaiScreen({Key? key}) : super(key: key);

  @override
  _DashboardPegawaiScreenState createState() => _DashboardPegawaiScreenState();
}

class _DashboardPegawaiScreenState extends State<DashboardPegawaiScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 48),
                  decoration: BoxDecoration(
                    color: appTheme.cyan100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildListpresensiman(context),
                        SizedBox(height: 14),
                        // Tombol Riwayat
                        CustomElevatedButton(
                          height: 50.h,
                          text: "Riwayat",
                          margin: EdgeInsets.symmetric(horizontal: 10.h),
                          buttonStyle: CustomButtonStyles.fillWhiteA,
                          buttonTextStyle: CustomTextStyles.titleSmallPrimary,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiwayatScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildColumnprice(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListpresensiman(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: List.generate(
            3,
            (index) {
              final texts = ["Presensi\nManual", "Pengajuan\nCuti", "KiP APP"];
              final imagePaths = [
                ImageConstant.imgEdit,
                ImageConstant.imgCalendar,
                ImageConstant.imgDownload
              ];
              return ListpresensimanItemWidget(
                text: texts[index],
                imagePath: imagePaths[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  // Navigasi berdasarkan indeks
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuAbsenManualPegawai1Screen(),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PengajuanCutiPegawaiScreen(),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KipappPegawaiOneScreen(),
                      ),
                    );
                  }
                },
                selectedTextColor: Color(0xFF3E9B97),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildColumnprice(BuildContext context) {
    // Ambil hari saat ini (1 = Senin, 7 = Minggu)
    DateTime currentTime = DateTime.now();
    print("Waktu saat ini: $currentTime");
    print("Waktu UTC: ${currentTime.toUtc()}");
    int today = currentTime.weekday; // Hari dalam minggu (1 = Senin, 7 = Minggu)

    // Tentukan jam mulai dan selesai berdasarkan hari
    String startTime = "";
    String endTime = "";

    if (today >= 1 && today <= 4) {
      // Senin - Kamis
      startTime = "08:00";
      endTime = "16:00";
    } else if (today == 5) {
      // Jumat
      startTime = "08:30";
      endTime = "16:30";
    } else {
      // Sabtu - Minggu (bisa sesuaikan jika ada jadwal lain)
      startTime = "Libur";
      endTime = "Libur";
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header bagian atas
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoBps,
                    height: 40.h,
                    width: 50.h,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.h,
                      top: 6.h,
                    ),
                    child: Text(
                      "GOVERNMENT APPROVAL",
                      style: theme.textTheme.titleSmall,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 12.h,
              ),
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
                  SizedBox(
                    width: double.maxFinite,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileInfoScreen(),
                          ),
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
                                Text(
                                  "Hi, Ruthveralda Sakoikoi",
                                  style: theme.textTheme.titleSmall,
                                ),
                                Text(
                                  "IPDS",
                                  style: CustomTextStyles
                                      .labelMediumErrorContainer,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
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
                                style:
                                    CustomTextStyles.titleLargeErrorContainer,
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
                              margin: EdgeInsets.only(
                                left: 22.h,
                                top: 4.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.h),
                              child: Text(
                                endTime,
                                style:
                                    CustomTextStyles.titleLargeErrorContainer,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
