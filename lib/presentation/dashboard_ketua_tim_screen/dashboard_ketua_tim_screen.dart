import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'widgets/listcell_one_item_widget.dart';
import 'widgets/listpresensiman1_item_widget.dart';

// ignore_for_file: must_be_immutable
class DashboardKetuaTimScreen extends StatelessWidget {
  DashboardKetuaTimScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  TextEditingController cellsixController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: SizeUtils.height,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.h,
                      vertical: 48.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.cyan100,
                      borderRadius: BorderRadiusStyle.roundedBorder90,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildListpresensiman(context),
                        SizedBox(height: 14.h),
                        CustomDropDown(
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
                          items: dropdownItemList,
                          contentPadding: EdgeInsets.fromLTRB(18.h, 2.h, 12.h, 2.h),
                          borderDecoration: DropDownStyleHelper.outlineErrorContainer,
                        ),
                        SizedBox(height: 14.h),
                        _buildTable(context),
                        SizedBox(height: 210.h)
                      ],
                    ),
                  ),
                  _buildColumnprice(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildListpresensiman(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10.h,
          children: List.generate(
            3,
            (index) {
              return Listpresensiman1ItemWidget();
            },
          ),
        ),
      ),
    );
  }


/// Section Widget
Widget _buildJavier(BuildContext context) {
  return CustomOutlinedButton(
    height: 36.h,
    width: 76.h,
    text: "Javier",
    buttonStyle: CustomButtonStyles.outlineGray,
    buttonTextStyle: theme.textTheme.bodySmall!,
  );
}

/// Section Widget
Widget _buildPresensimanual(BuildContext context) {
  return CustomOutlinedButton(
    height: 36.h,
    width: 138.h,
    text: "Presensi Manual",
    buttonStyle: CustomButtonStyles.outlineGray,
    buttonTextStyle: theme.textTheme.bodySmall!,
  );
}

/// Section Widget
Widget _buildPresensimanual1(BuildContext context) {
  return CustomOutlinedButton(
    height: 36.h,
    width: 138.h,
    text: "Presensi Manual",
    buttonStyle: CustomButtonStyles.outlineGray,
    buttonTextStyle: theme.textTheme.bodySmall!,
  );
}

/// Section Widget
Widget _buildCellsix(BuildContext context) {
  return CustomTextFormField(
    width: 118.h,
    controller: cellsixController,
    contentPadding: EdgeInsets.all(12.h),
    borderDecoration: TextFormFieldStyleHelper.outlineGray,
  );
}

/// Section Widget
Widget _buildTable(BuildContext context) {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: appTheme.whiteA700,
      borderRadius: BorderRadiusStyle.roundedBorder4,
      border: Border.all(
        color: appTheme.gray700,
        width: 1.h,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.whiteA700.withOpacity(0.05),
                border: Border(
                  top: BorderSide(
                    color: appTheme.gray700,
                    width: 1.h,
                  ),
                  left: BorderSide(
                    color: appTheme.gray700,
                    width: 1.h,
                  ),
                ),
              ),
              child: Text(
                "Nama",
                textAlign: TextAlign.left,
                style: CustomTextStyles.labelLargeErrorContainer12,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.whiteA700.withOpacity(0.05),
                border: Border(
                  top: BorderSide(
                    color: appTheme.gray700,
                    width: 1.h,
                  ),
                  left: BorderSide(
                    color: appTheme.gray700,
                    width: 1.h,
                  ),
                ),
              ),
              child: Text(
                "Jenis Pengajuan",
                textAlign: TextAlign.left,
                style: CustomTextStyles.labelLargeErrorContainer12,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30.h,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.whiteA700.withOpacity(0.05),
                border: Border(
                  top: BorderSide(
                    color: appTheme.gray700,
                    width: 1.h,
                  ),
                  left: BorderSide(
                    color: appTheme.gray700,
                    width: 1.h,
                  ),
                ),
              ),
              child: Text(
                "Status",
                textAlign: TextAlign.center,
                style: CustomTextStyles.labelLargeErrorContainer12,
              ),
            )
          ],
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(right: 2.h),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildJavier(context),
                    _buildPresensimanual(context),
                    Container(
                      padding: EdgeInsets.only(
                        top: 6.h,
                        right: 2.h,
                        bottom: 6.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: appTheme.gray700,
                            width: 1.h,
                          ),
                          left: BorderSide(
                            color: appTheme.gray700,
                            width: 1.h,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.h,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: appTheme.yellowA700,
                              borderRadius: BorderRadiusStyle.roundedBorder4,
                            ),
                            child: Text(
                              "Menunggu Persetujuan",
                              textAlign: TextAlign.left,
                              style: theme.textTheme.labelSmall,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36.h,
                      width: 76.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: appTheme.gray700,
                            width: 1.h,
                          ),
                          left: BorderSide(
                            color: appTheme.gray700,
                            width: 1.h,
                          ),
                        ),
                      ),
                    ),
                    _buildPresensimanual1(context),
                    _buildCellsix(context)
                  ],
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListcellOneItemWidget();
                },
              )
            ],
          ),
        )
      ],
    ),
  );
}
/// Section Widget
Widget _buildColumnprice(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        top: 24.h,
        right: 18.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLogoBps,
                  height: 28.h,
                  width: 40.h,
                  margin: EdgeInsets.only(left: 26.h),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10.h,
                      top: 4.h,
                    ),
                    child: Text(
                      "BADAN PUSAT STATISTIK",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgMdnotificationsnone,
                  height: 24.h,
                  width: 26.h,
                  onTap: () {},
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 18.h),
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
                      imagePath: ImageConstant.imgAvatars3dAvatar21,
                      height: 40.h,
                      width: 40.h,
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Ketua Tim",
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            "IPDS",
                            style: theme.textTheme.bodySmall,
                          )
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

/// Navigates to the detailAbsensiManualKetuaTimScreen when the action is triggered.
onTapRowone(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.detailAbsensiManualKetuaTimScreen);
}

/// Navigates to the notifikasiKetuaTimScreen when the action is triggered.
onTapImgMdnotifications(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.notifikasiKetuaTimScreen);
}

/// Navigates to the profileInfoKetuaTimScreen when the action is triggered.
onTapRowavatars3d(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.profileInfoKetuaTimScreen);
}
}
