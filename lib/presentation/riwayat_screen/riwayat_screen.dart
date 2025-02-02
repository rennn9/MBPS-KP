import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';

import './widgets/riwayat_one_item_widget.dart';
import '../detail_riwayat_kipapp_pegawai_screen/detail_riwayat_kipapp_pegawai_screen.dart';
import '../detail_riwayat_kipapp_pegawai_screen_tahun/detail_riwayat_kipapp_pegawai_screen_tahun.dart';
import '../detail_riwayat_pegawai_four_screen/detail_riwayat_pegawai_four_screen.dart';
import '../detail_riwayat_pegawai_screen/detail_riwayat_pegawai_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  /// Simpan submissions docs
  List<QueryDocumentSnapshot> submissionDocs = [];

  /// Mapping status => Bahasa Indonesia
  String _mapStatus(String rawStatus) {
    switch (rawStatus) {
      case 'PROCESSING':
        return 'Sedang diproses';
      case 'TEAM_REJECTED':
        return 'Ditolak oleh Ketua Tim';
      case 'TEAM_APPROVED':
        return 'Menunggu Persetujuan\nPimpinan';
      case 'HEAD_REJECTED':
        return 'Ditolak oleh Pimpinan';
      case 'HEAD_APPROVED':
        return 'Disetujui oleh Pimpinan';
      case 'CANCELED':
        return 'Dibatalkan';
      default:
        return '';
    }
  }

  Future<void> _downloadExcel(BuildContext context) async {
    try {
      // Periksa dan minta izin penyimpanan
      bool isPermissionGranted = await _request_per(Permission.storage);
      if (!isPermissionGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Izin penyimpanan diperlukan untuk mengunduh file')),
        );
        return;
      }

      // Buat workbook Excel
      var excel = Excel.createExcel();

      // Gunakan sheet default (biasanya bernama "Sheet1")
      var sheet = excel.sheets.values.first;

      // Tambahkan header ke file Excel
      sheet.appendRow(["Judul", "Deskripsi", "Status", "Tanggal"]);

      // Tambahkan data dari riwayat ke Excel
      for (var doc in submissionDocs) {
        final data = doc.data() as Map<String, dynamic>;
        final rawStatus = data['status'] ?? '';
        final status = _mapStatus(rawStatus);

        final submissionType = data['submission_type'] ?? '';
        final submissionData = data['submission_data'] ?? {};
        final dateFormat = DateFormat("d MMMM yyyy", "id_ID");

        String displayedType = '';
        String displayedDate = '';

        if (submissionType == "Presensi Manual") {
          final date = submissionData['attendance_date']?.toDate();
          displayedDate = dateFormat.format(date);
          displayedType = submissionData['attendance_type'] ?? '';
        }

        if (submissionType == "Pengajuan Cuti") {
          displayedType = submissionData['leave_type'] ?? '';

          if (submissionData['leave_type'] == "Cuti Setengah Hari") {
            final date = submissionData['date']?.toDate();
            displayedDate = dateFormat.format(date);
          } else {
            final startTime = submissionData['start_time']?.toDate();
            displayedDate = dateFormat.format(startTime);
          }
        }

        if (submissionType == "KiP APP") {
          final date = data['created_at']?.toDate();
          displayedType = submissionData['kipapp_type'];
          displayedDate = dateFormat.format(date);
        }

        // Tambahkan baris data ke sheet default
        sheet.appendRow([submissionType, displayedType, status, displayedDate]);
      }

      // Simpan file Excel ke dalam folder Downloads
      Directory directory;
      if (defaultTargetPlatform == TargetPlatform.android) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final filePath = '${directory.path}/rekapan_riwayat.xlsx';
      final fileBytes = excel.encode();
      final file = File(filePath);
      await file.writeAsBytes(fileBytes!, flush: true);

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File Excel berhasil diunduh ke $filePath')),
      );
    } catch (e) {
      debugPrint("Error generating or saving Excel: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal membuat file Excel: $e")),
      );
    }
  }

  Future<bool> _request_per(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

    if (build.version.sdkInt >= 30) {
      // For Android 11+ (SDK 30 and above)
      var re = await Permission.manageExternalStorage.request();
      return re.isGranted;
    } else {
      // For Android versions below 11
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        return result.isGranted;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingWidth: 43.h,
          leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftWhiteA700,
            margin: EdgeInsets.only(left: 33.h),
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: AppbarTitle(text: "Riwayat"),
          actions: [
            IconButton(
              icon: const Icon(Icons.download, color: Colors.white),
              onPressed: () => _downloadExcel(context),
              tooltip: "Download Rekapan",
            ),
          ],
          styleType: Style.bgFillTeal200,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('submissions')
              .where('user_id',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint("Terjadi error: ${snapshot.error}");
              return Center(child: Text("Terjadi error: ${snapshot.error}"));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            try {
              final docs = snapshot.data!.docs;
              submissionDocs = docs;

              if (docs.isEmpty) {
                return const Center(child: Text("Belum ada riwayat"));
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 22.h),
                physics: const BouncingScrollPhysics(),
                itemCount: docs.length,
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final data = doc.data() as Map<String, dynamic>;

                  // Ambil status mentah
                  final rawStatus = data['status'] ?? '';
                  // Ubah status ke bhs indonesia
                  final displayedStatus = _mapStatus(rawStatus);

                  final dateFormat = DateFormat("d MMMM yyyy", "id_ID");

                  final submissionType = data['submission_type'] ?? '';
                  final submissionData = data['submission_data'] ?? {};

                  String displayedType = '';
                  String displayedDate = '';

                  if (submissionType == "Presensi Manual") {
                    final date = submissionData['attendance_date']?.toDate();
                    displayedDate = dateFormat.format(date);

                    displayedType = submissionData['attendance_type'] ?? '';
                  }

                  if (submissionType == "Pengajuan Cuti") {
                    displayedType = submissionData['leave_type'] ?? '';

                    if (submissionData['leave_type'] == "Cuti Setengah Hari") {
                      final date = submissionData['date']?.toDate();
                      displayedDate = dateFormat.format(date);
                    } else {
                      final startTime = submissionData['start_time']?.toDate();
                      displayedDate = dateFormat.format(startTime);
                    }
                  }

                  if (submissionType == "KiP APP") {
                    final date = data['created_at']?.toDate();
                    displayedType = submissionData['kipapp_type'];
                    displayedDate = dateFormat.format(date);
                  }

                  return RiwayatOneItemWidget(
                    title: submissionType,
                    description: displayedType,
                    status: displayedStatus,
                    date: displayedDate,
                    onTapRow: () {
                      if (submissionType == "Presensi Manual") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailRiwayatPegawaiFourScreen(
                              data: data, // Kirimkan seluruh data dokumen
                              submissionId: doc.id,
                            ),
                          ),
                        );
                      } else if (submissionType == "Pengajuan Cuti") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailRiwayatPegawaiScreen(
                              data: data, // Kirimkan seluruh data dokumen
                              submissionId: doc.id,
                            ),
                          ),
                        );
                      } else if (submissionType == "KiP APP") {
                        if (displayedType == "Bulanan") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailRiwayatKipappPegawaiScreen(
                                data: data, // Kirimkan seluruh data dokumen
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailRiwayatKipappPegawaiScreenTahun(
                                data: data, // Kirimkan seluruh data dokumen
                              ),
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              );
            } catch (e) {
              debugPrint("Error parsing data: $e");
              return Center(
                child: Text("Terjadi kesalahan memproses data."),
              );
            }
          },
        ),
      ),
    );
  }
}
