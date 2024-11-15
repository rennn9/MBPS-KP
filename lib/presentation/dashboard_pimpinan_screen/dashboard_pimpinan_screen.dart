import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import 'widgets/expandablelists_item_widget.dart';
import 'widgets/listpresensiman2_item_widget.dart';

// ignore_for_file: must_be_immutable
class DashboardPimpinanScreen extends StatelessWidget {
  DashboardPimpinanScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: Form(
          key: _formKey,
          child: Container(
            height: 836.h,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 24.h,
                    right: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.cyan100,
                    borderRadius: BorderRadiusStyle.roundedBorder90,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 10.h),
                      _buildListpresensiman(context),
                      SizedBox(height: 14.h),
                      Padding(
                        padding: EdgeInsets.only(right: 6.h),
                        child: CustomDropDown(
                          width: 178.h,
                          icon: Container(
                            margin: EdgeInsets.only(left: 8.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownPrimary,
                              height: 30.h,
                              width: 18.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          iconSize: 30.h,
                          hintText: "Semua Permohonan",
                          alignment: Alignment.centerRight,
                          items: dropdownItemList,
                          contentPadding:
                              EdgeInsets.fromLTRB(18.h, 2.h, 12.h, 2.h),
                          borderDecoration:
                              DropDownStyleHelper.outlineErrorContainer,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text(
                            "Divisi",
                            style: CustomTextStyles.titleMediumSemiBold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildExpandablelists(context)
                    ],
                  ),
                ),
                _buildColumnavatars3d(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
  return CustomAppBar(
    height: 56.h,
    leadingWidth: 68.h,
    leading: AppbarLeadingImage(
      imagePath: ImageConstant.imgLogoBps,
      height: 28.h,
      width: 38.h,
      margin: EdgeInsets.only(left: 30.h),
    ),
    title: AppbarSubtitle(
      text: "BADAN PUSAT STATISTIK",
      margin: EdgeInsets.only(left: 10.h),
    ),
    actions: [
      AppbarTrailingImage(
        imagePath: ImageConstant.imgMdnotificationsnone,
        height: 24.h,
        width: 24.h,
        margin: EdgeInsets.only(right: 21.h),
        onTap: () {},
      )
    ],
  );
}

/// Section Widget  
Widget _buildListpresensiman(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 2.h),
    padding: EdgeInsets.symmetric(horizontal: 2.h),
    width: double.maxFinite,
    child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10.h,
        children: List.generate(
          3,
          (index) {
            return Listpresensiman2ItemWidget();
          },
        ),
      ),
    ),
  );
}

/// Section Widget  
Widget _buildExpandablelists(BuildContext context) {
  return Expanded(
    child: Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 2.h),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          return ExpandablelistsItemWidget(
            onTapRowone: () {},
          );
        },
      ),
    ),
  );
}

/// Section Widget  
Widget _buildColumnavatars3d(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                  border: Border.all(
                    color: appTheme.gray30001,
                    width: 1.h,
                  ),
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgAvatars3dAvatar21120x120,
                      height: 40.h,
                      width: 40.h,
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Pimpinan",
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            "BPS",
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

/// Navigates to the notifikasiPimpinanScreen when the action is triggered.  
onTapMdnotifications(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.notifikasiPimpinanScreen);
}

/// Navigates to the detailAbsensiManualPimpinanScreen when the action is triggered.  
onTapRowone(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.detailAbsensiManualPimpinanScreen);
}

/// Navigates to the profileInfoPimpinanScreen when the action is triggered.  
onTapRowavatars3d(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.profileInfoPimpinanScreen);
}
}