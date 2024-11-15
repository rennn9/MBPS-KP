import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable

class PengajuanCutiSetengahHariPegawaiScreen extends StatelessWidget {
  PengajuanCutiSetengahHariPegawaiScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  TextEditingController berikanController = TextEditingController();
  String radioGroup = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 14.h,
            top: 20.h,
            right: 14.h,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 2.h),
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildColumnmdone(context),
                      SizedBox(height: 14.h),
                      _buildColumnmdtwo(context),
                      SizedBox(height: 14.h),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Text(
                          "Sesi Cuti",
                          style: CustomTextStyles.titleLargeErrorContainer,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildGroup1134(context),
                      Spacer(),
                      CustomElevatedButton(
                        height: 32.h,
                        width: 76.h,
                        text: "Submit",
                        margin: EdgeInsets.only(right: 6.h),
                        buttonStyle: CustomButtonStyles.fillTeal,
                        buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
                        onPressed: () {},
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6.h)
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
  Widget _buildColumnmdone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
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
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnmdtwo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28.h,
            width: 68.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "Alasan",
                  style: CustomTextStyles.titleLargeErrorContainer,
                ),
                Text(
                  "Alasan",
                  style: CustomTextStyles.titleLargeErrorContainer,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          CustomTextFormField(
            controller: berikanController,
            hintText: "Berikan Alasan...",
            hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.all(14.h),
            borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL4,
            filled: true,
            fillColor: appTheme.whiteA700,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGroup1134(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22.h),
      child: Column(
        children: [
          CustomRadioButton(
            text: "Sesi pagi\n07.30-12.00",
            value: "Sesi pagi\n07.30-12.00",
            groupValue: radioGroup,
            isExpandedText: true,
            onChange: (value) {
              radioGroup = value;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: CustomRadioButton(
              text: "Sesi siang\n13:00-16:00",
              value: "Sesi siang\n13:00-16:00",
              groupValue: radioGroup,
              isExpandedText: true,
              onChange: (value) {
                radioGroup = value;
              },
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

  /// Navigates to the submitBerhasilScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
  }
}
