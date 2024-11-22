import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable

class KipappPegawaiOneScreen extends StatelessWidget {
  KipappPegawaiOneScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  bool januarione = false;
  bool februarione = false;
  bool maretone = false;
  bool aprilone = false;
  bool meione = false;
  bool junione = false;
  bool julione = false;
  bool agustusone = false;
  bool septemberone = false;
  bool oktoberone = false;
  bool novemberone = false;
  bool desemberone = false;

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
                top: 24.h,
                right: 14.h,
              ),
              child: Column(
                children: [
                  SizedBox(height: 4.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 2.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: 2.h,
                            right: 6.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder10,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgGrid,
                                        height: 32.h,
                                        width: 36.h,
                                      ),
                                      Text(
                                        "Bulanan",
                                        style: CustomTextStyles.titleMediumWhiteA700,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 18.h),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: double.maxFinite,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: appTheme.blueGray50,
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder10,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgClose,
                                          height: 32.h,
                                          width: 36.h,
                                        ),
                                        Text(
                                            "Tahunan",
                                            style: CustomTextStyles.titleMediumPrimary,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(right: 4.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.h,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                            borderRadius: BorderRadiusStyle.roundedBorder10,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.errorContainer
                                    .withOpacity(0.05),
                                spreadRadius: 2.h,
                                blurRadius: 2.h,
                                offset: Offset(
                                  0,
                                  0,
                                ),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomDropDown(
                                width: 94.h,
                                hintText: "2024",
                                hintStyle: CustomTextStyles.bodyMediumOnPrimary,
                                items: dropdownItemList,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.h),
                                borderDecoration:
                                    DropDownStyleHelper.fillIndigo,
                                fillColor: appTheme.indigo50,
                              ),
                              SizedBox(height: 14.h),
                              _buildJanuarione(context),
                              SizedBox(height: 14.h),
                              _buildFebruarione(context),
                              SizedBox(height: 14.h),
                              _buildMaretone(context),
                              SizedBox(height: 14.h),
                              _buildAprilone(context),
                              SizedBox(height: 14.h),
                              _buildMeione(context),
                              SizedBox(height: 14.h),
                              _buildJunione(context),
                              SizedBox(height: 14.h),
                              _buildJulione(context),
                              SizedBox(height: 14.h),
                              _buildAgustusone(context),
                              SizedBox(height: 14.h),
                              _buildSeptemberone(context),
                              SizedBox(height: 14.h),
                              _buildOktoberone(context),
                              SizedBox(height: 14.h),
                              _buildNovemberone(context),
                              SizedBox(height: 14.h),
                              _buildDesemberone(context),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: CustomElevatedButton(
                            height: 32.h,
                            width: 77.h,
                            text: "Submit",
                            buttonStyle: CustomButtonStyles.fillTeal,
                            buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
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
        height: 16.h,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {},
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "KipAPP",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildJanuarione(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Januari",
        value: januarione,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          januarione = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildFebruarione(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Februari",
        value: februarione,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          februarione = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildMaretone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Maret",
        value: maretone,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          maretone = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildAprilone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "April",
        value: aprilone,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          aprilone = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildMeione(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Mei",
        value: meione,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          meione = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildJunione(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Juni",
        value: junione,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          junione = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildJulione(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Juli",
        value: julione,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          julione = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildAgustusone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Agustus",
        value: agustusone,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          agustusone = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildSeptemberone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "September",
        value: septemberone,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          septemberone = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildOktoberone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Oktober",
        value: oktoberone,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          oktoberone = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildNovemberone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "November",
        value: novemberone,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          novemberone = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildDesemberone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: "Desember",
        value: desemberone,
        padding: EdgeInsets.fromLTRB(26.h, 14.h, 30.h, 14.h),
        textStyle: CustomTextStyles.bodyMediumErrorContainer,
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          desemberone = value;
        },
      ),
    );
  }
  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context); // Navigasi kembali ke layar sebelumnya
  }

  /// Navigates to the kipappPegawaiTwoScreen when the action is triggered.
  onTapColumncloseone(BuildContext context) {
    Navigator.pushNamed(
        context,
        AppRoutes
            .kipappPegawaiTwoScreen); // Pindah ke layar kipappPegawaiTwoScreen
  }

  /// Navigates to the submitBerhasilScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context,
        AppRoutes.submitBerhasilScreen); // Pindah ke layar submitBerhasilScreen
  }
}

