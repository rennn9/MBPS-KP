import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_outlined_button.dart';

// ignore: must_be_immutable
class DetailPengajuanKipappKetuaTimScreenTahun extends StatelessWidget {
  final Map<String, dynamic>? data;
  DetailPengajuanKipappKetuaTimScreenTahun({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = data?['Nama'];
    String teamName = data?['Tim'];
    Map submissionData = data?['Submission Data'];

    // Inisialisasi status bulan berdasarkan data Firestore
    final Map<String, bool> yearsStatus = {
      "2024": false,
      "2025": false,
      "2026": false,
      "2027": false,
    };

    // Update status bulan yang telah diajukan
    if (data != null) {
      List<String>? submittedYears =
          List<String>.from(submissionData['submission_data']['years'] ?? []);
      for (String year in submittedYears) {
        if (yearsStatus.containsKey(year)) {
          yearsStatus[year] = true;
        }
      }
    }

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
                top: 16.h,
                right: 14.h,
              ),
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 2.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1030.h,
                          width: double.maxFinite,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.only(
                                  left: 12.h,
                                  top: 10.h,
                                  right: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder14,
                                  border: Border.all(
                                    color: appTheme.blueGray100,
                                    width: 1.h,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 52.h),
                                    Text(
                                      username,
                                      style: CustomTextStyles
                                          .titleLargeErrorContainer,
                                    ),
                                    Text(
                                      teamName,
                                      style: CustomTextStyles
                                          .titleSmallErrorContainer,
                                    ),
                                    SizedBox(height: 18.h),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Divider(
                                        color: theme.colorScheme.errorContainer
                                            .withOpacity(0.3),
                                        indent: 4.h,
                                        endIndent: 6.h,
                                      ),
                                    ),
                                    SizedBox(height: 22.h),
                                    Container(
                                      height: 818.h,
                                      width: double.maxFinite,
                                      margin: EdgeInsets.only(left: 2.h),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 46.h,
                                                top: 294.h,
                                              ),
                                              child: Text(
                                                "Tolak",
                                                style: CustomTextStyles
                                                    .titleSmallWhiteA700_1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  width: double.maxFinite,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomOutlinedButton(
                                                        width: 110.h,
                                                        text: "Bulan",
                                                        buttonStyle:
                                                            CustomButtonStyles
                                                                .outlinePrimaryTL6,
                                                        buttonTextStyle:
                                                            CustomTextStyles
                                                                .titleMediumPrimary,
                                                        // onPressed: () {
                                                        //   Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           DetailPengajuanKipappKetuaTimScreen(),
                                                        //     ),
                                                        //   );
                                                        // },
                                                      ),
                                                      CustomOutlinedButton(
                                                        width: 110.h,
                                                        text: "Tahun",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 32.h),
                                                _buildYearCheckbox(
                                                    context,
                                                    "Tahun 2024",
                                                    yearsStatus['2024']!),
                                                SizedBox(height: 12.5.h),
                                                _buildYearCheckbox(
                                                    context,
                                                    "Tahun 2025",
                                                    yearsStatus['2025']!),
                                                SizedBox(height: 12.5.h),
                                                _buildYearCheckbox(
                                                    context,
                                                    "Tahun 2026",
                                                    yearsStatus['2026']!),
                                                SizedBox(height: 12.5.h),
                                                _buildYearCheckbox(
                                                    context,
                                                    "Tahun 2027",
                                                    yearsStatus['2027']!),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 106.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder52,
                                    border: Border.all(
                                      color: appTheme.whiteA700,
                                      width: 2.h,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 98.h,
                                        width: 98.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.blue300,
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder48,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              username[0].toUpperCase(),
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 30.h),
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

  /// Checkbox Widget
  Widget _buildYearCheckbox(BuildContext context, String year, bool isChecked) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomCheckboxButton(
        text: year,
        value: isChecked,
        padding: EdgeInsets.fromLTRB(24.h, 14.h, 30.h, 14.h),
        decoration: CustomCheckBoxStyleHelper.outlineErrorContainer,
        onChange: (value) {
          isChecked = value;
        },
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
