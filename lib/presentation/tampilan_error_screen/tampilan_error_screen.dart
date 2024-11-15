import 'package:flutter/material.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class TampilanErrorScreen extends StatelessWidget {
  const TampilanErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 14,
            top: 168,
            right: 14,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildColumnscreensho(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 10,
      leading: AppbarLeadingImage(
        imagePath: "assets/images/img_arrow_left_white_a700.svg",
        margin: EdgeInsets.only(left: 33),
        onTap: () {},
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildColumnscreensho(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 2),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Opacity(
            opacity: 0.6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 38),
              child: Image.asset(
                "assets/images/img_screenshot_2024.png",
                height: 208,
                width: double.maxFinite,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Halaman ini sedang bermasalah :(",
            style: TextStyle(
              color: Color(0X19000000).withOpacity(0.48),
              fontSize: 19,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Silahkan coba lagi nanti",
            style: TextStyle(
              color: Color(0XFF858585),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 26),
          SizedBox(
            width: double.maxFinite,
            height: 36,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0XFF0994DE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                visualDensity: const VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                ),
              ),
              onPressed: () {},
              child: Text(
                "Refresh",
                style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
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
}
