import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable

class KipappPegawaiOneScreen extends StatefulWidget  {
  KipappPegawaiOneScreen({Key? key}) : super(key: key);
  @override
  _KipappPegawaiOneScreenState createState() => _KipappPegawaiOneScreenState();
}

  class _KipappPegawaiOneScreenState extends State<KipappPegawaiOneScreen> {
  List<String> dropdownItemList = ["2024", "2025", "2026"];


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

  bool get isSubmitEnabled =>
      januarione ||
      februarione ||
      maretone ||
      aprilone ||
      meione ||
      junione ||
      julione ||
      agustusone ||
      septemberone ||
      oktoberone ||
      novemberone ||
      desemberone ;

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
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.kipappPegawaiTwoScreen);
                                  },
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
                              SizedBox(height: 10.h),
                              _buildJanuarione(context),
                              SizedBox(height: 10.h),
                              _buildFebruarione(context),
                              SizedBox(height: 12.5.h),
                              _buildMaretone(context),
                              SizedBox(height: 10.h),
                              _buildAprilone(context),
                              SizedBox(height: 10.h),
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
                              SizedBox(height: 12.5.h),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: CustomElevatedButton(
                          height: 32.h,
                          width: 76.h,
                          text: "Submit",
                            buttonStyle: isSubmitEnabled
                                ? CustomButtonStyles.fillTeal
                                : CustomButtonStyles
                                    .fillGray, // Gaya tombol untuk tombol non-aktif
                            buttonTextStyle:
                                CustomTextStyles.titleSmallWhiteA700,
                            onPressed: isSubmitEnabled
                                ? () {
                                    Navigator.pushNamed(
                                        context, '/submit_berhasil_screen');
                                  }
                                : null, // Tombol tidak aktif jika isSubmitEnabled = false
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
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "KipAPP",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

 Widget _buildMonthCheckbox(
      {required BuildContext context,
      required String label,
      required bool value,
      required ValueChanged<bool?> onChanged}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Radius sudut container
        border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0)), // Warna border
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue[600],
            checkColor: Colors.white,
          ),
          const SizedBox(width: 8.0), // Jarak antara checkbox dan teks
          Text(
            label,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Warna teks hitam
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJanuarione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Januari",
      value: januarione,
      onChanged: (value) {
        setState(() {
          januarione = value ?? false;
        });
      },
    );
  }

  Widget _buildFebruarione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Februari",
      value: februarione,
      onChanged: (value) {
        setState(() {
          februarione = value ?? false;
        });
      },
    );
  }

 Widget _buildMaretone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Maret",
      value: maretone,
      onChanged: (value) {
        setState(() {
          maretone = value ?? false;
        });
      },
    );
  }

  Widget _buildAprilone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "April",
      value: aprilone,
      onChanged: (value) {
        setState(() {
          aprilone = value ?? false;
        });
      },
    );
  }

  Widget _buildMeione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Mei",
      value: meione,
      onChanged: (value) {
        setState(() {
          meione = value ?? false;
        });
      },
    );
  }

  Widget _buildJunione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Juni",
      value: junione,
      onChanged: (value) {
        setState(() {
          junione = value ?? false;
        });
      },
    );
  }

    Widget _buildJulione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Juli",
      value: julione,
      onChanged: (value) {
        setState(() {
          julione = value ?? false;
        });
      },
    );
  }

  Widget _buildAgustusone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Agustus",
      value: agustusone,
      onChanged: (value) {
        setState(() {
          agustusone = value ?? false;
        });
      },
    );
  }

  Widget _buildSeptemberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "September",
      value: septemberone,
      onChanged: (value) {
        setState(() {
          septemberone = value ?? false;
        });
      },
    );
  }

  Widget _buildOktoberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Oktober",
      value: oktoberone,
      onChanged: (value) {
        setState(() {
          oktoberone = value ?? false;
        });
      },
    );
  }

  Widget _buildNovemberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "November",
      value: novemberone,
      onChanged: (value) {
        setState(() {
          novemberone = value ?? false;
        });
      },
    );
  }

  Widget _buildDesemberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Desember",
      value: desemberone,
      onChanged: (value) {
        setState(() {
          desemberone = value ?? false;
        });
      },
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

