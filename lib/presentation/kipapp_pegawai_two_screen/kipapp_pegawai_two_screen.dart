import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class KipappPegawaiTwoScreen extends StatelessWidget {
  KipappPegawaiTwoScreen({Key? key}) : super(key: key);

  bool tahun2024one = false;
  bool tahun2025one = false;
  bool tahun2026one = false;
  bool tahun2027one = false;
  bool tahun2028one = false;

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
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 2.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: 2.h,
                          right: 6.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: appTheme.blueGray50,
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10,
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
                                      style:
                                          CustomTextStyles.titleMediumPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 18.h),
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgGrid,
                                      height: 32.h,
                                      width: 36.h,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Tahunan",
                                        style: CustomTextStyles
                                            .titleMediumWhiteA700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      _buildColumntahun2024(context),
                      Spacer(),
                      CustomElevatedButton(
                        height: 32.h,
                        width: 76.h,
                        text: "Submit",
                        buttonStyle: CustomButtonStyles.fillTeal,
                        buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h)
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
      height: 16.h,
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
Widget _buildColumntahun2024(BuildContext context) {
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.only(right: 4.h),
    padding: EdgeInsets.symmetric(
      horizontal: 12.h,
      vertical: 16.h,
    ),
    decoration: BoxDecoration(
      color: appTheme.whiteA700,
      borderRadius: BorderRadiusStyle.roundedBorder10,
      boxShadow: [
        BoxShadow(
          color: theme.colorScheme.errorContainer.withOpacity(0.05),
          spreadRadius: 2.h,
          blurRadius: 2.h,
          offset: Offset(
            0,
            0,
          ),
        )
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: CustomCheckboxButton(
            text: "Tahun 2024",
            value: tahun2024one,
            padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
            textStyle: CustomTextStyles.bodyMediumErrorContainer,
            decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
            onChange: (value) {
              tahun2024one = value;
            },
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          width: double.maxFinite,
          child: CustomCheckboxButton(
            text: "Tahun 2025",
            value: tahun2025one,
            padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
            textStyle: CustomTextStyles.bodyMediumErrorContainer,
            decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
            onChange: (value) {
              tahun2025one = value;
            },
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          width: double.maxFinite,
          child: CustomCheckboxButton(
            text: "Tahun 2026",
            value: tahun2026one,
            padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
            textStyle: CustomTextStyles.bodyMediumErrorContainer,
            decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
            onChange: (value) {
              tahun2026one = value;
            },
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          width: double.maxFinite,
          child: CustomCheckboxButton(
            text: "Tahun 2027",
            value: tahun2027one,
            padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
            textStyle: CustomTextStyles.bodyMediumErrorContainer,
            decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
            onChange: (value) {
              tahun2027one = value;
            },
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          width: double.maxFinite,
          child: CustomCheckboxButton(
            text: "Tahun 2028",
            value: tahun2028one,
            padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
            textStyle: CustomTextStyles.bodyMediumErrorContainer,
            decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
            onChange: (value) {
              tahun2028one = value;
            },
          ),
        )
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

/// Navigates to the submitBerhasilScreen when the action is triggered.
onTapSubmit(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
}
}
