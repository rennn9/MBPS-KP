import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class SplashscreenfiveScreen extends StatelessWidget {
  const SplashscreenfiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgGroup1,
                height: 126.h,
                width: double.maxFinite,
              ),
              SizedBox(height: 52.h),
              _buildColumnselamatda(context),
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgGroup2,
                height: 126.h,
                width: double.maxFinite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnselamatda(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 18.h,
        right: 14.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 52.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgLogoBps,
            height: 162.h,
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 12.h,
              right: 14.h,
            ),
          ),
          SizedBox(height: 50.h),
          Text(
            "Selamat Datang",
            style: CustomTextStyles.headlineLargeErrorContainer,
          ),
          RotationTransition(
            turns: AlwaysStoppedAnimation(
              -(-89 / 360),
            ),
            child: Text(
              ":)",
              style: theme.textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
