import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class KipappPegawaiScreen extends StatelessWidget {
  const KipappPegawaiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 14.h,
            top: 28.h,
            right: 14.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildColumnsmtwo(context)],
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
        text: "KipAPP",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildColumnsmtwo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 2.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: appTheme.blueGray50,
                      borderRadius: BorderRadiusStyle.roundedBorder10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgClose,
                          height: 32.h,
                          width: 36.h,
                          onTap: () {},
                        ),
                        Text(
                          "Bulanan",
                          style: CustomTextStyles.titleMediumPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 18.h),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: appTheme.blueGray50,
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgClose,
                            height: 32.h,
                            width: 36.h,
                            onTap: () {},
                          ),
                          Text(
                            "Tahunan",
                              style: CustomTextStyles.titleMediumPrimary,  
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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

  /// Navigates back to the previous screen.
  onTapImgCloseone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the kipappPegawaiTwoScreen when the action is triggered.
  onTapColumnclose(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.kipappPegawaiTwoScreen);
  }
}
