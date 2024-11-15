import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/riwayat_one_item_widget.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 18.h,
            top: 22.h,
            right: 18.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildRiwayatone(context)],
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
        text: "Riwayat",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildRiwayatone(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.h,
          );
        },
        itemCount: 6,
        itemBuilder: (context, index) {
          return RiwayatOneItemWidget(
            onTapRow18oktober: () {},
          );
        },
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the detailRiwayatPegawaiThreeScreen when the action is triggered.
  onTapRow18oktober(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.detailRiwayatPegawaiThreeScreen);
  }
}
