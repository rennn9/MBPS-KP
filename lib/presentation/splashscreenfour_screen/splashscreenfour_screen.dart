import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

class SplashscreenfourScreen extends StatelessWidget {
  const SplashscreenfourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 56.h,
          ),
          child: Column(
            children: [
              SizedBox(height: 98.h),
              CustomImageView(
                imagePath: ImageConstant.imgIlustrasiKippapp,
                height: 180.h,
                width: double.maxFinite,
              ),
              SizedBox(height: 20.h),
              Text(
                "KipAPP",
                style: CustomTextStyles.headlineSmallRoboto,
              ),
              Spacer(),
              CustomElevatedButton(
                height: 34.h,
                text: "Get Started",
                margin: EdgeInsets.only(
                  left: 44.h,
                  right: 38.h,
                ),
                buttonStyle: CustomButtonStyles.fillPrimaryTL5,
                buttonTextStyle: CustomTextStyles.labelLargeRobotoWhiteA700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      height: 56.h,
      actions: [
        AppbarSubtitleOne(
          text: "Skip",
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgArrowRight,
          height: 12.h,
          width: 12.h,
          margin: EdgeInsets.only(
            left: 9.h,
            right: 52.h,
          ),
        ),
      ],
    );
  }
}
