import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable

class KipappPegawaiTwoScreen extends StatefulWidget {
  KipappPegawaiTwoScreen({Key? key}) : super(key: key);
  @override
  _KipappPegawaiTwoScreenState createState() => _KipappPegawaiTwoScreenState();
}

class _KipappPegawaiTwoScreenState extends State<KipappPegawaiTwoScreen> {
  bool tahun2024one = false;
  bool tahun2025one = false;
  bool tahun2026one = false;
  bool tahun2027one = false;
  bool tahun2028one = false;

  bool get isSubmitEnabled =>
      tahun2024one ||
      tahun2025one ||
      tahun2026one ||
      tahun2027one ||
      tahun2028one;

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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.kipappPegawaiOneScreen);
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
                                          "Bulanan",
                                          style: CustomTextStyles
                                              .titleMediumPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 18.h),
                              Expanded(
                                  child: Container(
                                    width: double.maxFinite,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary,
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder10,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgGrid,
                                          height: 32.h,
                                          width: 36.h,
                                        ),
                                        Text(
                                          "Tahunan",
                                          style: CustomTextStyles
                                              .titleMediumWhiteA700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          width: double.maxFinite,
                          height: 460.h,
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
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10.h),
                              _build2024one(context),
                              SizedBox(height: 10.h),
                              _build2025one(context),
                              SizedBox(height: 12.5.h),
                              _build2026one(context),
                              SizedBox(height: 10.h),
                              _build2027one(context),
                              SizedBox(height: 10.h),
                              _build2028one(context),
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

  Widget _build2024one(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Tahun 2024",
      value: tahun2024one,
      onChanged: (value) {
        setState(() {
          tahun2024one = value ?? false;
        });
      },
    );
  }

  Widget _build2025one(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Tahun 2025",
      value: tahun2025one,
      onChanged: (value) {
        setState(() {
          tahun2025one = value ?? false;
        });
      },
    );
  }

  Widget _build2026one(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Tahun 2026",
      value: tahun2026one,
      onChanged: (value) {
        setState(() {
          tahun2026one = value ?? false;
        });
      },
    );
  }

  Widget _build2027one(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Tahun 2027",
      value: tahun2027one,
      onChanged: (value) {
        setState(() {
          tahun2027one = value ?? false;
        });
      },
    );
  }

  Widget _build2028one(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Tahun 2028",
      value: tahun2028one,
      onChanged: (value) {
        setState(() {
          tahun2024one = value ?? false;
        });
      },
    );
  }
}
