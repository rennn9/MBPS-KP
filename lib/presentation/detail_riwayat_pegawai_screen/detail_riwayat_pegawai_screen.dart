import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class DetailRiwayatPegawaiScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  final String? submissionId;

  DetailRiwayatPegawaiScreen({
    Key? key,
    this.data,
    this.submissionId,
  }) : super(key: key);

  /// Fungsi untuk membatalkan pengajuan
  Future<void> _cancelSubmission(BuildContext context) async {
    try {
      if (submissionId != null) {
        // Update status di Firebase
        await FirebaseFirestore.instance
            .collection('submissions')
            .doc(submissionId)
            .update({
          'status': 'CANCELED',
        });

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pengajuan berhasil dibatalkan')),
        );

        // Kembali ke halaman sebelumnya setelah status diperbarui
        Navigator.pop(context);
      }
    } catch (e) {
      // Tampilkan pesan error jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membatalkan pengajuan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final leaveType = data?['submission_data']['leave_type'] ?? '';
    final leaveStartDate = (leaveType == "Cuti Setengah Hari")
        ? (data?['submission_data']['date']?.toDate())
        : (data?['submission_data']['start_time']?.toDate());
    final formattedStartDate = leaveStartDate != null
        ? DateFormat("d MMMM yyyy", "id_ID").format(leaveStartDate)
        : 'Tidak tersedia';

    final createdAt = data?['created_at']?.toDate();
    final formattedCreatedAt = createdAt != null
        ? DateFormat("d MMMM yyyy", "id_ID").format(createdAt)
        : 'Tidak tersedia';

    final description = data?['submission_data']['reason'] ?? '';

    final rawStatus = data?['status'] ?? '';

    final statusList = _generateStatusList(rawStatus);

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
                          formattedStartDate,
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
                        const Divider(),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildRowTanggal(
                            context,
                            tanggalOne: "Tipe",
                            tanggalValue: leaveType,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildRowTanggal(
                            context,
                            tanggalOne: "Tanggal Pengajuan",
                            tanggalValue: formattedCreatedAt,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildRowTanggal(
                            context,
                            tanggalOne: "Tanggal Cuti",
                            tanggalValue: formattedStartDate,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Alasan Cuti",
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8.h),
                            border: Border.all(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.12)),
                          ),
                          child: Text(
                            description,
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Status",
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        _buildTimeline(statusList),
                        SizedBox(height: 18.h),
                        if (rawStatus ==
                            'PROCESSING') // Hanya tampil jika status adalah PROCESSING
                          ElevatedButton(
                            onPressed: () => _cancelSubmission(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Warna tombol merah
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Batalkan Pengajuan",
                                style: TextStyle(color: Colors.white),
                              ),
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

  /// Membuat daftar status berdasarkan status dari Firebase
  List<String> _generateStatusList(String rawStatus) {
    switch (rawStatus) {
      case 'PROCESSING':
        return ["Diajukan", "Sedang Diproses"];
      case 'TEAM_REJECTED':
        return ["Diajukan", "Sedang Diproses", "Ditolak oleh Ketua Tim"];
      case 'TEAM_APPROVED':
        return [
          "Diajukan",
          "Sedang Diproses",
          "Disetujui oleh Ketua Tim",
          "Menunggu persetujuan Pimpinan"
        ];
      case 'HEAD_REJECTED':
        return [
          "Diajukan",
          "Sedang Diproses",
          "Disetujui oleh Ketua Tim",
          "Ditolak oleh Pimpinan"
        ];
      case 'HEAD_APPROVED':
        return [
          "Diajukan",
          "Sedang Diproses",
          "Disetujui oleh Ketua Tim",
          "Disetujui oleh Pimpinan"
        ];
      case 'CANCELED':
        return ["Diajukan", "Sedang Diproses", "Dibatalkan"];
      default:
        return ["Status tidak diketahui"];
    }
  }

  /// Membuat timeline
  Widget _buildTimeline(List<String> statusList) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      theme: TimelineThemeData(
        nodePosition: 0.05,
        indicatorPosition: 0,
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: statusList.length,
        indicatorBuilder: (context, index) {
          final isProcessing = index == statusList.length - 1 &&
              (statusList.last == "Sedang Diproses" ||
                  statusList.last.contains("Menunggu"));
          final isRejected = index == statusList.length - 1 &&
              (statusList.last.contains("Ditolak") ||
                  statusList.last.contains("Dibatalkan"));

          return DotIndicator(
            size: 20.h,
            color: isRejected
                ? Colors.red
                : isProcessing
                    ? Colors.grey
                    : Colors.green,
            child: isProcessing
                ? null // Lingkaran kosong untuk status "Sedang Diproses"
                : Icon(
                    isRejected ? Icons.close : Icons.check,
                    color: Colors.white,
                    size: 12.h,
                  ),
          );
        },
        contentsBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 24.0),
            child: Text(
              statusList[index],
              style: TextStyle(
                fontSize: 14.h,
                fontWeight: FontWeight.w500,
                color: statusList[index].contains("Ditolak")
                    ? Colors.red
                    : Colors.black,
              ),
            ),
          );
        },
        connectorBuilder: (_, __, ___) => SolidLineConnector(
          thickness: 1.h,
          color: Colors.grey,
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
