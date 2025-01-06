import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../dashboard_pegawai_screen/dashboard_pegawai_screen.dart';

class NotifikasiTidakAdaScreen extends StatelessWidget {
  const NotifikasiTidakAdaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 14.h,
            top: 218.h,
            right: 14.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildColumnscreensho(context)],
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DashboardPegawaiScreen(), // Update with the correct screen class
            ),
            (route) => false, // Clears the navigation stack
          );
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Notifikasi",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildColumnscreensho(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 2.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgScreenshot2024,
            height: 152.h,
            width: 142.h,
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Tidak Ada Notifikasi",
              style: CustomTextStyles.titleLargeErrorContainer_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the tampilanErrorScreen when the action is triggered.
  onTapTxtSmone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.tampilanErrorScreen);
  }
}
