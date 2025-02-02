import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class DetailRiwayatKipappPegawaiScreenTahun extends StatelessWidget {
  final Map<String, dynamic>? data;

  DetailRiwayatKipappPegawaiScreenTahun({Key? key, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("d MMMM yyyy", "id_ID");
    final date = dateFormat.format(data!['created_at']?.toDate());

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
          List<String>.from(data?['submission_data']['years'] ?? []);
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
                      bottom: 200.h,
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
                          date,
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
                                      buttonStyle:
                                          CustomButtonStyles.outlinePrimaryTL6,
                                      buttonTextStyle:
                                          CustomTextStyles.titleMediumPrimary,
                                      // onPressed: () {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           DetailRiwayatKipappPegawaiScreen(),
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
                                  context, "Tahun 2024", yearsStatus['2024']!),
                              SizedBox(height: 12.5.h),
                              _buildYearCheckbox(
                                  context, "Tahun 2025", yearsStatus['2025']!),
                              SizedBox(height: 12.5.h),
                              _buildYearCheckbox(
                                  context, "Tahun 2026", yearsStatus['2026']!),
                              SizedBox(height: 12.5.h),
                              _buildYearCheckbox(
                                  context, "Tahun 2027", yearsStatus['2027']!),
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
