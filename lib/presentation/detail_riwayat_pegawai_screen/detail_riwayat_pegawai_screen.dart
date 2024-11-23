import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class DetailRiwayatPegawaiScreen extends StatelessWidget {
  DetailRiwayatPegawaiScreen({Key? key}) : super(key: key);

  TextEditingController loremipsumoneController = TextEditingController();

  final String teamLeaderDecision =
      "Ditolak oleh Ketua Tim"; // Bisa diganti menjadi "Diterima oleh Ketua Tim"

  final List<String> statusList = [
    "Diajukan",
    "Sedang Diproses",
    "Disetujui oleh Ketua Tim", // Sesuaikan dengan status Anda
    "Disetujui oleh Pimpinan",
  ];

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
              padding: const EdgeInsets.only(
                left: 18.0,
                top: 22.0,
                right: 18.0,
              ),
              child: Column(
                children: [
                  Container(
                    height: 668.h,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 16.0,
                      right: 20.0,
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
                          offset: const Offset(0, 4),
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
                        SizedBox(height: 2.h),
                        Text(
                          "18 Oktober 2024",
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
                        SizedBox(height: 14.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildRowTanggal(
                            context,
                            tanggalOne: "Tipe",
                            tanggalValue: "1 Hari",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildRowTanggal(
                            context,
                            tanggalOne: "Tanggal Pengajuan",
                            tanggalValue: "10 Oktober 2024",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildRowTanggal(
                            context,
                            tanggalOne: "Tanggal Cuti",
                            tanggalValue: "18 Oktober 2024",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Alasan Cuti",
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        CustomTextFormField(
                          controller: loremipsumoneController,
                          hintText:
                              "Lagi demam pak...",
                          textInputAction: TextInputAction.done,
                          maxLines: 4,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.h, 8.h, 10.h, 12.h),
                        ),
                        SizedBox(height: 8.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Status",
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Timeline.tileBuilder(
                            shrinkWrap: true,
                            theme: TimelineThemeData(
                              nodePosition: 0.2,
                              indicatorPosition: 0.5,
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              itemCount: statusList.length,
                              indicatorBuilder: (context, index) {
                                Color indicatorColor;
                                if (index == 0 ||
                                    index == 1 ||
                                    statusList[index] ==
                                        "Disetujui oleh Ketua Tim") {
                                  indicatorColor = Colors.green;
                                } else {
                                  indicatorColor = teamLeaderDecision ==
                                          "Ditolak oleh Ketua Tim"
                                      ? Colors.red
                                      : Colors.green;
                                }
                                return DotIndicator(
                                  size: 20.h,
                                  color: indicatorColor,
                                  child: Icon(
                                    index == statusList.length - 1 &&
                                            teamLeaderDecision ==
                                                "Ditolak oleh Ketua Tim"
                                        ? Icons.close
                                        : Icons.check,
                                    color: Colors.white,
                                    size: 12.h,
                                  ),
                                );
                              },
                              contentsBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 24.0),
                                  child: Text(
                                    statusList[index],
                                    style: TextStyle(
                                      fontSize: 14.h,
                                      fontWeight: FontWeight.w500,
                                      color: (index == statusList.length - 1 &&
                                              teamLeaderDecision ==
                                                  "Ditolak oleh Ketua Tim")
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                              connectorBuilder: (context, index, type) {
                                return SolidLineConnector(
                                  thickness: 1.h,
                                  color: index < statusList.length - 1
                                      ? Colors.grey
                                      : Colors.transparent,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),
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
        margin: const EdgeInsets.only(left: 33.0),
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

  /// Common widget
  Widget _buildRowTanggal(
    BuildContext context, {
    required String tanggalOne,
    required String tanggalValue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            tanggalOne,
            style: theme.textTheme.labelLarge!.copyWith(
              color: theme.colorScheme.errorContainer.withOpacity(0.4),
            ),
          ),
        ),
        Text(
          tanggalValue,
          style: CustomTextStyles.labelLargeErrorContainer.copyWith(
            color: theme.colorScheme.errorContainer.withOpacity(1),
          ),
        ),
      ],
    );
  }
}

/// Navigates back to the previous screen.
onTapArrowleftone(BuildContext context) {
  Navigator.pop(context);
}
