import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';

class SplashscreenoneScreen extends StatelessWidget {
  const SplashscreenoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 60.h,
          ),
          child: Column(
            children: [
              Spacer(),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 2.h),
                padding: EdgeInsets.symmetric(horizontal: 18.h),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLogoBps,
                      height: 200.h,
                      width: double.maxFinite,
                    ),
                    SizedBox(height: 174.h),
                    SizedBox(
                      height: 8.h,
                      child: AnimatedSmoothIndicator(
                        activeIndex: 0,
                        count: 3,
                        effect: ScrollingDotsEffect(
                          spacing: 9,
                          activeDotColor: appTheme.gray800,
                          dotColor: appTheme.gray800.withOpacity(0.6),
                          dotHeight: 8.h,
                          dotWidth: 8.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomIconButton(
                      height: 42.h,
                      width: 42.h,
                      padding: EdgeInsets.all(10.h),
                      decoration: IconButtonStyleHelper.outlineErrorContainer,
                      onTap: () => onTapBtnArrowforward(
                          context), // Navigasi ditambahkan di sini
                      child: CustomImageView(
                        imagePath: ImageConstant.imgArrowForwardIos,
                        
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the splashscreentwoScreen when the action is triggered.
  onTapBtnArrowforward(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.splashscreentwoScreen);
  }
}
