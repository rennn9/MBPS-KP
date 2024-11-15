import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import 'widgets/columndiajukan_item_widget.dart';
import 'widgets/columnview_item_widget.dart';

// ignore_for_file: must_be_immutable

class DetailRiwayatPegawaiScreen extends StatelessWidget {
  DetailRiwayatPegawaiScreen({Key? key}) : super(key: key);

  TextEditingController lagidemamController = TextEditingController();

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
                left: 18.h,
                top: 22.h,
                right: 18.h,
              ),
              child: Column(
                children: [
                  Container(
                    height: 668.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      left: 18.h,
                      top: 18.h,
                      right: 18.h,
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
                          offset: Offset(
                            0,
                            4,
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Pengajuan Cuti",
                          style: theme.textTheme.titleSmall,
                        ),
                        Text(
                          "18 Oktober 2024",
                          style: theme.textTheme.labelMedium,
                        ),
                        SizedBox(height: 30.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Text(
                              "Info Pengajuan",
                              style: CustomTextStyles.titleSmallMedium,
                            ),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 2.h),
                          child: _buildRowtanggal(
                            context,
                            tanggalOne: "Tipe",
                            p10oktober2024: "1 Hari",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            color: theme.colorScheme.errorContainer,
                            indent: 2.h,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 2.h),
                          child: _buildRowtanggal(
                            context,
                            tanggalOne: "Tanggal Pengajuan",
                            p10oktober2024: "10 Oktober 2024",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            color: theme.colorScheme.errorContainer,
                            indent: 2.h,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 2.h),
                          child: _buildRowtanggal(
                            context,
                            tanggalOne: "Tanggal Cuti",
                            p10oktober2024: "18 Oktober 2024",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            color: theme.colorScheme.errorContainer,
                            indent: 2.h,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Text(
                              "Alasan Cuti",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h),
                          child: CustomTextFormField(
                            controller: lagidemamController,
                            hintText: "Lagi demam pak...",
                            textInputAction: TextInputAction.done,
                            maxLines: 4,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.h, 8.h, 10.h, 12.h),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Text(
                              "Status",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          margin: EdgeInsets.only(left: 2.h),
                          height: 190.h,
                          width: double.maxFinite,
                          child: Timeline.tileBuilder(
                            shrinkWrap: true,
                            theme: TimelineThemeData(
                              nodePosition: 0.2,
                              indicatorPosition: 0.5,
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              itemCount: 4,
                              indicatorBuilder: (context, index) {
                                return ColumnviewItemWidget();
                              },
                              contentsBuilder: (context, index) {
                                return ColumndiajukanItemWidget();
                              },
                              connectorBuilder: (context, index, type) {
                                return SolidLineConnector(
                                  thickness: 1.h,
                                  color: theme.colorScheme.errorContainer
                                      .withOpacity(0.4),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h)
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
        text: "Detail Riwayat",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Common widget
  Widget _buildRowtanggal(
    BuildContext context, {
    required String tanggalOne,
    required String p10oktober2024,
  }) {
    return Row(
      children: [
        Text(
          tanggalOne,
          style: theme.textTheme.labelLarge!.copyWith(
            color: theme.colorScheme.errorContainer.withOpacity(0.4),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 28.h),
          child: Text(
            p10oktober2024,
            style: CustomTextStyles.labelLargeErrorContainer.copyWith(
              color: theme.colorScheme.errorContainer.withOpacity(1),
            ),
          ),
        ),
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
