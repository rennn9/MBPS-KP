import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class PengajuanCutiPegawaiScreen extends StatelessWidget {
  PengajuanCutiPegawaiScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  TextEditingController group37040oneController = TextEditingController();
  TextEditingController stashdatadateliController = TextEditingController();
  TextEditingController berikanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 14.h,
                top: 20.h,
                right: 14.h,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 2.h),
                    padding: EdgeInsets.symmetric(horizontal: 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildOpsijeniscuti(context),
                        SizedBox(height: 24.h),
                        _buildColumnmdone(context),
                        SizedBox(height: 14.h),
                        _buildMulai(context),
                        SizedBox(height: 16.h),
                        _buildSelesai(context),
                        SizedBox(height: 16.h),
                        _buildColumnmdfour(context),
                        SizedBox(height: 122.h),
                        _buildSubmit(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h)
                ],
              ),
            ),
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
        text: "Cuti",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildOpsijeniscuti(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jenis Cuti",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 12.h),
          CustomDropDown(
            icon: Container(
              margin: EdgeInsets.only(left: 16.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgArrowdownErrorcontainer26x18,
                height: 26.h,
                width: 18.h,
                fit: BoxFit.contain,
              ),
            ),
            iconSize: 26.h,
            hintText: "Tahunan",
            items: dropdownItemList,
            contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGroup37040one(BuildContext context) {
    return CustomTextFormField(
      controller: group37040oneController,
      hintText: "0",
      hintStyle: theme.textTheme.titleSmall!,
      contentPadding: EdgeInsets.all(14.h),
      borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL4,
      filled: true,
      fillColor: appTheme.whiteA700,
    );
  }

  /// Section Widget
  Widget _buildColumnmdone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lama Cuti",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 12.h),
          _buildGroup37040one(context),
        ],
      ),
    );
  }
/// Section Widget
Widget _buildMulai(BuildContext context) {
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.only(right: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mulai",
          style: CustomTextStyles.titleLargeErrorContainer,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 50.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: theme.colorScheme.errorContainer,
                    width: 2.h,
                  ),
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                ),
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.only(right: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder4,
                    border: Border.all(
                      color: theme.colorScheme.errorContainer,
                      width: 2.h,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgVector,
                        height: 12.h,
                        width: 14.h,
                        margin: EdgeInsets.only(right: 4.h),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgVectorErrorcontainer,
                        height: 22.h,
                        width: 22.h,
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 14.h),
                  child: Text(
                    "Pilih Tanggal Mulai",
                    style: CustomTextStyles.bodyMediumErrorContainer_1,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

/// Section Widget
Widget _buildStashdatadateli(BuildContext context) {
  return CustomTextFormField(
    controller: stashdatadateliController,
    hintText: "Pilih Tanggal Selesai",
    hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
    suffix: Container(
      margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
      child: CustomImageView(
        imagePath: ImageConstant.imgStashdatadatelight,
        height: 26.h,
        width: 32.h,
        fit: BoxFit.contain,
      ),
    ),
    suffixConstraints: BoxConstraints(
      maxHeight: 50.h,
    ),
    contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
    borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
  );
}

/// Section Widget
Widget _buildSelesai(BuildContext context) {
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.only(right: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selesai",
          style: CustomTextStyles.titleLargeErrorContainer,
        ),
        SizedBox(height: 10.h),
        _buildStashdatadateli(context)
      ],
    ),
  );
}

/// Section Widget
Widget _buildBerikan(BuildContext context) {
  return CustomTextFormField(
    controller: berikanController,
    hintText: "Berikan Alasan...",
    hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
    textInputAction: TextInputAction.done,
    contentPadding: EdgeInsets.all(14.h),
    borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL4,
    filled: true,
    fillColor: appTheme.whiteA700,
  );
}

/// Section Widget
Widget _buildColumnmdfour(BuildContext context) {
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.only(right: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alasan",
          style: CustomTextStyles.titleLargeErrorContainer,
        ),
        SizedBox(height: 12.h),
        _buildBerikan(context)
      ],
    ),
  );
}

/// Section Widget
Widget _buildSubmit(BuildContext context) {
  return CustomElevatedButton(
    height: 32.h,
    width: 76.h,
    text: "Submit",
    margin: EdgeInsets.only(right: 2.h),
    buttonStyle: CustomButtonStyles.fillTeal,
    buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
    onPressed: () {},
  );
}

/// Navigates back to the previous screen.
onTapArrowleftone(BuildContext context) {
  Navigator.pop(context);
}

/// Navigates to the submitBerhasilScreen when the action is triggered.
onTapSubmit(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
}
}
