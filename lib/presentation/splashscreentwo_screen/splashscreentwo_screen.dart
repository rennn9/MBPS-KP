import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';

class SplashscreentwoScreen extends StatelessWidget {
  const SplashscreentwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 14.h,
            top: 60.h,
            right: 14.h,
          ),
          child: Column(
            children: [
              SizedBox(height: 94.h),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 2.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgIlustrasiAbsensi,
                        height: 180.h,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(right: 2.h),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Absensi Manual",
                        style: theme.textTheme.headlineSmall,
                      ),
                      Spacer(),
                      SizedBox(
                        height: 8.h,
                        child: AnimatedSmoothIndicator(
                          activeIndex: 0,
                          count: 3,
                          effect: ScrollingDotsEffect(
                            spacing: 9,
                            activeDotColor: appTheme.gray50002,
                            dotColor: appTheme.gray800,
                            dotHeight: 8.h,
                            dotWidth: 8.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: 16.h,
                          right: 2.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              height: 32.h,
                              width: 32.h,
                              padding: EdgeInsets.all(10.h),
                              decoration: IconButtonStyleHelper.none,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.splashscreenoneScreen);
                              },
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgArrowForwardIosGreen50001,
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 50.h),
                            child: CustomElevatedButton(
                              height: 26.h,
                              width: 78.h,
                              text: "Next",
                              rightIcon: Container(
                                margin: EdgeInsets.only(left: 4.h),
                                child: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgArrowrightWhiteA700,
                                  height: 14.h,
                                  width: 12.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              buttonTextStyle:
                                  CustomTextStyles.labelMediumRobotoWhiteA700,
                              onPressed: () {
                                  Navigator.pushNamed(context,
                                      AppRoutes.splashscreenthreeScreen);
                                },
                              alignment: Alignment.topCenter,
                              ),  
                              ),
                          ],

                        ),
                      ),
                    ],
                  ),
                ),
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
          onTap: () {
            Navigator.pushNamed(
                context,
                AppRoutes.signupUpScreen); 
          },
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgArrowRight,
          height: 12.h,
          width: 12.h,
          margin: EdgeInsets.only(
            left: 9.h,
            right: 49.h,
          ),
        ),
      ],
    );
  }

  /// Navigates to the splashscreenoneScreen when the action is triggered.
  onTapBtnArrowforward(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.splashscreenoneScreen);
  }

  /// Navigates to the splashscreenthreeScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.splashscreenthreeScreen);
  }
}
