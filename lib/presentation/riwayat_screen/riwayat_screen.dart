import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/riwayat_one_item_widget.dart';

class RiwayatItem {
  final String title;
  final String description;
  final String status;
  final String date;
  final String route;

  RiwayatItem({
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.route,
  });
}

class RiwayatScreen extends StatelessWidget {
  RiwayatScreen({Key? key}) : super(key: key);

  final List<RiwayatItem> riwayatItems = [
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti 1 hari",
      status: "Disetujui",
      date: "18 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiScreen,
    ),
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti setengah hari",
      status: "Disetujui",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiOneScreen,
    ),
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti setengah hari",
      status: "Ditolak",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiTwoScreen,
    ),
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti 1 hari",
      status: "Disetujui",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiThreeScreen,
    ),
    RiwayatItem(
      title: "Presensi Manual",
      description: "WFOL",
      status: "Ditolak",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiFourScreen,
    ),
    // Tambahkan item lain sesuai kebutuhan
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 18.h,
            top: 22.h,
            right: 18.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildRiwayatone(context)],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Riwayat",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildRiwayatone(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.h,
          );
        },
        itemCount: riwayatItems.length,
        itemBuilder: (context, index) {
          final item = riwayatItems[index];
          return RiwayatOneItemWidget(
            title: item.title,
            description: item.description,
            status: item.status,
            date: item.date,
            onTapRow18oktober: () {
              Navigator.pushNamed(context, item.route);
            },
          );
        },
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the detailRiwayatPegawaiThreeScreen when the action is triggered.
  onTapRow18oktober(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.riwayatScreen);
  }
}
