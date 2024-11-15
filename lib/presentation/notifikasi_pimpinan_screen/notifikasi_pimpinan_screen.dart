import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import 'widgets/listandi1_item_widget.dart';

class NotifikasiPimpinanScreen extends StatelessWidget {
  const NotifikasiPimpinanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 8.h,
            top: 18.h,
            right: 8.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildHariini(context),
              SizedBox(height: 18.h),
              _buildListandi(context),
            ],
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
        onTap: () {},
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Notifikasi",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildHariini(BuildContext context) {
    return CustomOutlinedButton(
      height: 22.h,
      width: 100.h,
      text: "Hari Ini",
      buttonStyle: CustomButtonStyles.outlineIndigo,
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimary,
    );
  }

  /// Section Widget
  Widget _buildListandi(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 8.h,
          );
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return Listandi1ItemWidget(
            onTapRowandilatifah: () {},
          );
        },
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the detailPengajuanCutiPimpinanOneScreen when the action is triggered.
  onTapRowandilatifah(BuildContext context) {
    Navigator.pushNamed(
        context, AppRoutes.detailPengajuanCutiPimpinanOneScreen);
  }
}
