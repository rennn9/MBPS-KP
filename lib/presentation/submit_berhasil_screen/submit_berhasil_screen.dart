import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';

class SubmitBerhasilScreen extends StatelessWidget {
  const SubmitBerhasilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 184.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      left: 18.h,
                      right: 14.h,
                    ),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgCheckMark150x150,
                          height: 150.h,
                          width: 152.h,
                        ),
                        SizedBox(height: 26.h),
                        Text(
                          "Pengajuan Berhasil!!!",
                          style: CustomTextStyles.titleLargeErrorContainer,
                        ),
                        Text(
                          "Silakan tunggu konfirmasi lebih lanjut",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 326.h),
                        CustomElevatedButton(
                          height: 32.h,
                          width: 84.h,
                          text: "Close",
                          buttonStyle: CustomButtonStyles.fillTeal,
                          buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
                          onPressed: () => onTapClose(context), // Updated here
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 64.h),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.h,
                      vertical: 190.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.cyan100,
                      borderRadius: BorderRadiusStyle.roundedBorder186,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [_buildColumn(context)],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgGroup,
            height: 298.h,
            width: double.maxFinite,
          )
        ],
      ),
    );
  }

  /// Navigates to the dashboardPegawaiScreen when the action is triggered.
  onTapClose(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dashboardPegawaiScreen); // Navigation logic
  }
}
