import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../detail_riwayat_kipapp_pegawai_screen_tahun/detail_riwayat_kipapp_pegawai_screen_tahun.dart';

// ignore_for_file: must_be_immutable
class DetailRiwayatKipappPegawaiScreen extends StatelessWidget {
  DetailRiwayatKipappPegawaiScreen({Key? key}) : super(key: key);

  bool januarione = true;
  bool februarione = true;
  bool maretone = true;
  bool aprilone = true;
  bool meione = true;
  bool junione = true;
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
              padding: EdgeInsets.all(18.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      left: 20.h,
                      top: 14.h,
                      right: 20.h,
                      bottom: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadiusStyle.roundedBorder14,
                      border: Border.all(
                        color: theme.colorScheme.errorContainer,
                        width: 1.h,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.errorContainer
                              .withOpacity(0.25),
                          spreadRadius: 2.h,
                          blurRadius: 2.h,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 4.h),
                        Text(
                          "KipAPP",
                          style: theme.textTheme.titleSmall,
                        ),
                        Text(
                          "14 Oktober 2024",
                          style: theme.textTheme.labelMedium,
                        ),
                        SizedBox(height: 30.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Info Pengajuan",
                            style: CustomTextStyles.titleSmallMedium,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(),
                        ),
                        SizedBox(height: 22.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 8.h),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomOutlinedButton(
                                      width: 110.h,
                                      text: "Bulan",
                                    ),
                                    CustomOutlinedButton(
                                      width: 110.h,
                                      text: "Tahun",
                                      buttonStyle:
                                          CustomButtonStyles.outlinePrimaryTL6,
                                      buttonTextStyle:
                                          CustomTextStyles.titleMediumPrimary,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailRiwayatKipappPegawaiScreenTahun(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 32.h),
                              _buildJanuarione(context),
                              SizedBox(height: 12.5.h),
                              _buildFebruarione(context),
                              SizedBox(height: 12.5.h),
                              _buildMaretone(context),
                              SizedBox(height: 12.5.h),
                              _buildAprilone(context),
                              SizedBox(height: 12.5.h),
                              _buildMeione(context),
                              SizedBox(height: 12.5.h),
                              _buildJunione(context),
                              SizedBox(height: 12.5.h),
                              _buildJulione(context),
                              SizedBox(height: 12.5.h),
                              _buildAgustusone(context),
                              SizedBox(height: 12.5.h),
                              _buildSeptemberone(context),
                              SizedBox(height: 12.5.h),
                              _buildOktoberone(context),
                              SizedBox(height: 12.5.h),
                              _buildNovemberone(context),
                              SizedBox(height: 12.5.h),
                              _buildDesemberone(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
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
      onTap: () {
          Navigator.pop(context);
        },
    ),
    centerTitle: true,
    title: AppbarTitle(
      text: "Detail Riwayat",
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
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
      padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
      decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
      onChange: (value) {
        desemberone = value;
      },
    ),
  );
}

/// Navigates back to the previous screen.
onTapArrowleftone(BuildContext context) {
  Navigator.pop(context);
}
}

