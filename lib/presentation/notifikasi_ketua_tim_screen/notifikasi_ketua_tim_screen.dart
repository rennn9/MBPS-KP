import 'package:flutter/material.dart';
import 'package:projectbps/presentation/dashboard_ketua_tim_screen/dashboard_ketua_tim_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/listandi_item_widget.dart';

class NotifikasiKetuaTimScreen extends StatelessWidget {
  const NotifikasiKetuaTimScreen({Key? key}) : super(key: key);

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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 26.h),
                decoration: BoxDecoration(
                  color: appTheme.indigo50,
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                  border: Border.all(
                    color: appTheme.indigo50,
                    width: 1.h,
                  ),
                ),
                child: Text(
                  "Hari Ini",
                  textAlign: TextAlign.left,
                  style: CustomTextStyles.titleSmallOnPrimary,
                ),
              ),
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
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardKetuaTimScreen(),
            ),
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
          return ListandiItemWidget(
            onTapRowandilatifah: () {
              Navigator.pushNamed(
                context,
                AppRoutes.detailPengajuanCutiKetuaTimOneScreen,
              );
            },
          );
        },
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the detailPengajuanCutiKetuaTimOneScreen when the action is triggered.
  onTapRowandilatifah(BuildContext context) {
    Navigator.pushNamed(
        context, AppRoutes.detailPengajuanCutiKetuaTimOneScreen);
  }
}
