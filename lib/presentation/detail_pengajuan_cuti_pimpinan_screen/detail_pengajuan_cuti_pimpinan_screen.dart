import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable

class DetailPengajuanCutiPimpinanScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  DetailPengajuanCutiPimpinanScreen({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<DetailPengajuanCutiPimpinanScreen> createState() =>
      _DetailPengajuanCutiPimpinanScreenState();
}

class _DetailPengajuanCutiPimpinanScreenState
    extends State<DetailPengajuanCutiPimpinanScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("d MMMM yyyy", "id_ID");

    String username = widget.data?['Nama'];
    String teamName = widget.data?['Tim'];
    String profile = widget.data?['Profile'];
    String submissionId = widget.data?['Id'];
    String status = widget.data?['Status'];
    Map submissionData = widget.data?['Submission Data'];

    String leaveType = submissionData['submission_data']['leave_type'] ?? '';
    String leaveSession =
        submissionData['submission_data']['leave_session'] == 'pagi'
            ? 'Cuti pagi (07:30-12:00)'
            : submissionData['submission_data']['leave_session'] == 'siang'
                ? 'Cuti siang (12:30-16:00)'
                : '';
    String reason = submissionData['submission_data']['reason'] ?? '-';
    String date = leaveType == "Cuti Setengah Hari"
        ? dateFormat.format(submissionData['submission_data']['date']?.toDate())
        : dateFormat
            .format(submissionData['submission_data']['start_time']?.toDate());
    String createdAt =
        dateFormat.format(submissionData['created_at']?.toDate());

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Stack(
          children: [
            Opacity(
              opacity: isLoading ? 0.5 : 1.0, // Mengurangi opacity saat loading
              child: AbsorbPointer(
                absorbing: isLoading, // Blokir interaksi saat loading
                child: SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 734.h,
                      width: double.maxFinite,
                      padding: EdgeInsets.only(
                        left: 28.h,
                        top: 18.h,
                        right: 28.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 592.h,
                            width: double.maxFinite,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.only(
                                    left: 8.h,
                                    top: 24.h,
                                    right: 8.h,
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
                                      SizedBox(height: 10.h),
                                      Text(
                                        username,
                                        style: theme.textTheme.titleMedium,
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
                                          color: theme
                                              .colorScheme.errorContainer
                                              .withOpacity(0.3),
                                          indent: 18.h,
                                          endIndent: 14.h,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text(
                                            "Info Pengajuan",
                                            style: CustomTextStyles
                                                .titleSmallMedium,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 14.h),
                                      Container(
                                        width: double.maxFinite,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                        child: _buildRowtanggal(
                                          context,
                                          tanggalOne: "Tipe",
                                          p10oktober2024: leaveType,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      if (leaveType == 'Cuti Setengah Hari')
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: double.maxFinite,
                                              child: Divider(
                                                indent: 4.h,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Container(
                                              width: double.maxFinite,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4.h),
                                              child: _buildRowtanggal(
                                                context,
                                                tanggalOne: "Jenis Cuti",
                                                p10oktober2024: leaveSession,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                          ],
                                        ),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Divider(indent: 4.h),
                                      ),
                                      SizedBox(height: 8.h),
                                      Container(
                                        width: double.maxFinite,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                        child: _buildRowtanggal(
                                          context,
                                          tanggalOne: "Tanggal Pengajuan",
                                          p10oktober2024: createdAt,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Divider(indent: 4.h),
                                      ),
                                      SizedBox(height: 8.h),
                                      Container(
                                        width: double.maxFinite,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                        child: _buildRowtanggal(
                                          context,
                                          tanggalOne: "Tanggal Cuti",
                                          p10oktober2024: date,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Divider(indent: 4.h),
                                      ),
                                      SizedBox(height: 8.h),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text(
                                            "Alasan Cuti",
                                            style: theme.textTheme.labelLarge,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.h,
                                                vertical: 8
                                                    .h), // Menambah padding agar teks tidak menempel
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  8.h), // Menambahkan border-radius jika diinginkan
                                              border: Border.all(
                                                color: appTheme
                                                    .blueGray100, // Menambahkan border dengan warna
                                                width: 1.h, // Ketebalan border
                                              ),
                                            ),
                                            child: Text(
                                              reason,
                                              style: CustomTextStyles
                                                  .labelLargeErrorContainer
                                                  .copyWith(
                                                color: theme
                                                    .colorScheme.errorContainer
                                                    .withOpacity(
                                                        1), // Anda bisa menyesuaikan gaya teks di sini
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        width: double.maxFinite,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                        child: _buildRowtanggal(
                                          context,
                                          tanggalOne: "Status",
                                          p10oktober2024: status,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Divider(indent: 4.h),
                                      ),
                                      SizedBox(height: 52.h),
                                      if (status.toLowerCase() ==
                                          "Menunggu Persetujuan".toLowerCase())
                                        _buildActionButtons(
                                            context,
                                            submissionId,
                                            "HEAD_APPROVED",
                                            "HEAD_REJECTED"),
                                      if (status.toLowerCase() ==
                                          "Ditolak".toLowerCase())
                                        _buildSingleActionButton(
                                            context,
                                            submissionId,
                                            "TEAM_APPROVED",
                                            "Batalkan Penolakan",
                                            Colors.red),
                                      if (status.toLowerCase() ==
                                          "Disetujui".toLowerCase())
                                        _buildSingleActionButton(
                                            context,
                                            submissionId,
                                            "TEAM_APPROVED",
                                            "Batalkan Persetujuan",
                                            Colors.orange),
                                      SizedBox(height: 40.h),
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
                                        ClipOval(
                                          child: CustomImageView(
                                            imagePath: profile,
                                            height: 120.h,
                                            width: 120.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, String submissionId,
      String approveStatus, String rejectStatus) {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
            text: "Tolak",
            onPressed: () {
              _updateSubmissionStatus(context, submissionId, rejectStatus);
            },
          ),
        ),
        SizedBox(width: 16.h),
        Expanded(
          child: CustomElevatedButton(
            text: "Terima",
            buttonStyle: CustomButtonStyles.fillGreenA,
            onPressed: () {
              _updateSubmissionStatus(context, submissionId, approveStatus);
            },
          ),
        )
      ],
    );
  }

  Widget _buildSingleActionButton(BuildContext context, String submissionId,
      String newStatus, String buttonText, Color buttonColor) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: CustomElevatedButton(
        text: buttonText,
        buttonStyle: CustomButtonStyles.fillPrimary
            .copyWith(backgroundColor: MaterialStateProperty.all(buttonColor)),
        onPressed: () {
          _updateSubmissionStatus(context, submissionId, newStatus);
        },
      ),
    );
  }

  Future<void> _updateSubmissionStatus(
      context, String? submissionId, String status) async {
    if (submissionId == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('submissions')
          .doc(submissionId)
          .update({'status': status});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status pengajuan berhasil diperbarui')),
      );
      Navigator.pushNamed(context, '/dashboard_pimpinan_screen');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui status: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
        text: "Pengajuan Cuti",
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              tanggalOne,
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.errorContainer.withOpacity(0.4),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: Text(
            p10oktober2024,
            style: CustomTextStyles.labelLargeErrorContainer.copyWith(
              color: theme.colorScheme.errorContainer.withOpacity(1),
            ),
          ),
        )
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
