import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class MenuAbsenManualPegawai2Screen extends StatelessWidget {
  MenuAbsenManualPegawai2Screen({Key? key}) : super(key: key);

  TextEditingController stashdatadateliController = TextEditingController();
  TextEditingController group37018oneController = TextEditingController();
  TextEditingController group37017oneController = TextEditingController();
  TextEditingController weuipencilfilleController = TextEditingController();

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
                        _buildTip(context),
                        SizedBox(height: 18.h),
                        _buildColumnmdtwo(context),
                        SizedBox(height: 16.h),
                        _buildColumnmdthree(context),
                        SizedBox(height: 16.h),
                        _buildColumnmdfour(context),
                        SizedBox(height: 54.h),
                        _buildSubmit(context)
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
        text: "Absensi Manual",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildWfo(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 60.h,
        text: "WFO",
        buttonStyle: CustomButtonStyles.fillErrorContainer,
        buttonTextStyle: CustomTextStyles.titleMediumErrorContainer_1,
        onPressed: () {},
      ),
    );
  }

  /// Section Widget
  Widget _buildWfol(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 60.h,
        text: "WFOL",
        buttonStyle: CustomButtonStyles.fillErrorContainer,
        buttonTextStyle: theme.textTheme.titleMedium!,
      ),
    );
  }

  /// Section Widget
  Widget _buildTip(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kehadiran",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                _buildWfo(context),
                SizedBox(width: 28.h),
                _buildWfol(context)
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
      hintText: "21 Oktober 2024",
      hintStyle: CustomTextStyles.bodyMediumErrorContainer,
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
  Widget _buildColumnmdtwo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal Absen",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 10.h),
          _buildStashdatadateli(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGroup37018one(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: group37018oneController,
      hintText: "08.03",
      hintStyle: CustomTextStyles.bodyMediumErrorContainer,
      contentPadding: EdgeInsets.all(14.h),
      borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
      onTap: () {},
    );
  }

  /// Section Widget
  Widget _buildGroup37017one(BuildContext context) {
    return CustomTextFormField(
      controller: group37017oneController,
      hintText: "17.31",
      hintStyle: CustomTextStyles.bodyMediumErrorContainer,
      contentPadding: EdgeInsets.all(14.h),
      borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
    );
  }

  /// Section Widget
  Widget _buildColumnmdthree(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jam Absen",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 14.h),
          _buildGroup37018one(context),
          SizedBox(height: 14.h),
          _buildGroup37017one(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildWeuipencilfille(BuildContext context) {
    return CustomTextFormField(
      controller: weuipencilfilleController,
      hintText: "Lembur menyelesaikan proyek",
      hintStyle: CustomTextStyles.bodyMediumErrorContainer,
      textInputAction: TextInputAction.done,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 12.h, 14.h, 12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgWeuipencilfilledGray50001,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 150.h,
      ),
      maxLines: 6,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 12.h,
      ),
      borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
    );
  }

  /// Section Widget
  Widget _buildColumnmdfour(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alasan",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 10.h),
          _buildWeuipencilfille(context)
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

  /// Navigates to the menuAbsenManualPegawai1Screen when the action is triggered.
  onTapWfo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menuAbsenManualPegawai1Screen);
  }

  /// Navigates to the submitBerhasilScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
  }
}
