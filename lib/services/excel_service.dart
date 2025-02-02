import 'dart:io';
import 'package:excel/excel.dart' as exc;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExcelService {
  /// --------------------------------------------------------------------------
  ///  Fungsi untuk mengunduh (download) file Excel berisi data rekapan.
  ///  Param [tableData] adalah list of map yang sudah dikumpulkan di screen
  ///  (berisi "Jenis Pengajuan", "Submission Data", dsb).
  /// --------------------------------------------------------------------------
  static Future<void> downloadRekapan(
    BuildContext context,
    List<Map<String, dynamic>> tableData,
    String label,
  ) async {
    try {
      // 1) Periksa dan minta izin penyimpanan
      bool isPermissionGranted = await _requestStoragePermission();
      if (!isPermissionGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Izin penyimpanan diperlukan untuk mengunduh file')),
        );
        return;
      }

      // 2) Membuat file Excel
      var excel = exc.Excel.createExcel();

      // 3) Pisahkan data berdasarkan "Jenis Pengajuan"
      Map<String, List<Map<String, dynamic>>> categorizedData = {
        'Presensi Manual': [],
        'Pengajuan Cuti': [],
        'KiP APP': [],
      };

      for (var row in tableData) {
        final submissionType = row['Jenis Pengajuan'];
        if (categorizedData.containsKey(submissionType)) {
          categorizedData[submissionType]!.add(row);
        }
      }

      // 4) Tambahkan data ke sheet masing-masing jenis pengajuan
      for (var category in categorizedData.entries) {
        final String sheetName = category.key;
        final List<Map<String, dynamic>> rows = category.value;

        // Buat sheet untuk kategori pengajuan
        var sheetObject = excel[sheetName];

        // Tambahkan header ke sheet
        if (sheetName == 'Presensi Manual') {
          sheetObject.appendRow([
            'Nama',
            'Jenis Pengajuan',
            'Status',
            'Jenis Kehadiran',
            'Tanggal Kehadiran',
            'Jam Mulai',
            'Jam Selesai',
            'Deskripsi',
          ]);
        } else if (sheetName == 'Pengajuan Cuti') {
          sheetObject.appendRow([
            'Nama',
            'Jenis Pengajuan',
            'Status',
            'Jenis Cuti',
            'Lama Cuti',
            'Tanggal Mulai',
            'Tanggal Selesai',
            'Sesi Cuti',
            'Reason',
          ]);
        } else if (sheetName == 'KiP APP') {
          sheetObject.appendRow([
            'Nama',
            'Jenis Pengajuan',
            'Tipe KiP APP',
            'Tahun',
            'Bulan',
          ]);
        }

        // 5) Isi data baris
        for (var row in rows) {
          final submissionData =
              row['Submission Data']?['submission_data'] ?? {};
          final status = row['Status'] ?? '';
          final nama = row['Nama'] ?? '';
          final jenisPengajuan = row['Jenis Pengajuan'] ?? '';

          if (sheetName == 'Presensi Manual') {
            sheetObject.appendRow([
              nama,
              jenisPengajuan,
              status,
              submissionData['attendance_type'] ?? '',
              // Tanggal Kehadiran
              submissionData['attendance_date'] != null
                  ? DateFormat("d MMMM yyyy", "id_ID").format(
                      (submissionData['attendance_date'] as Timestamp).toDate())
                  : '',
              // Jam Mulai
              submissionData['start_time'] != null
                  ? DateFormat("HH:mm").format(
                      (submissionData['start_time'] as Timestamp).toDate())
                  : '',
              // Jam Selesai
              submissionData['end_time'] != null
                  ? DateFormat("HH:mm").format(
                      (submissionData['end_time'] as Timestamp).toDate())
                  : '',
              submissionData['description'] ?? ''
            ]);
          } else if (sheetName == 'Pengajuan Cuti') {
            final leaveType = submissionData['leave_type'] ?? '';
            if (leaveType == 'Cuti Setengah Hari') {
              sheetObject.appendRow([
                nama,
                jenisPengajuan,
                status,
                leaveType,
                'Setengah hari',
                submissionData['date'] != null
                    ? DateFormat("d MMMM yyyy", "id_ID")
                        .format((submissionData['date'] as Timestamp).toDate())
                    : '',
                submissionData['date'] != null
                    ? DateFormat("d MMMM yyyy", "id_ID")
                        .format((submissionData['date'] as Timestamp).toDate())
                    : '',
                submissionData['leave_session'] ?? '',
                submissionData['reason'] ?? '',
              ]);
            } else {
              sheetObject.appendRow([
                nama,
                jenisPengajuan,
                status,
                leaveType,
                '${submissionData['duration_leave']?.toString()} hari',
                submissionData['start_time'] != null
                    ? DateFormat("d MMMM yyyy", "id_ID").format(
                        (submissionData['start_time'] as Timestamp).toDate())
                    : '',
                submissionData['end_time'] != null
                    ? DateFormat("d MMMM yyyy", "id_ID").format(
                        (submissionData['end_time'] as Timestamp).toDate())
                    : '',
                '-',
                submissionData['reason'] ?? '',
              ]);
            }
          } else if (sheetName == 'KiP APP') {
            final kipappType = submissionData['kipapp_type'] ?? '';
            if (kipappType == 'Bulanan') {
              sheetObject.appendRow([
                nama,
                jenisPengajuan,
                kipappType,
                submissionData['year'] ?? '',
                submissionData['months']?.join(', ') ?? '',
              ]);
            } else {
              sheetObject.appendRow([
                nama,
                jenisPengajuan,
                kipappType,
                submissionData['years']?.join(', ') ?? '',
                '-',
              ]);
            }
          }
        }
      }

      // 6) Tentukan path penyimpanan
      Directory? directory;
      if (defaultTargetPlatform == TargetPlatform.android) {
        // Android (khusus)
        directory = Directory('/storage/emulated/0/Download');
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }
      } else {
        // iOS, web, desktop, dsb.
        directory = await getApplicationDocumentsDirectory();
      }

      // 7) Buat nama file
      String baseFileName = '';
      if (label != '') {
        baseFileName = 'rekapan_${label.replaceAll(" ", "_")}.xlsx';
      } else {
        baseFileName = 'rekapan_pengajuan.xlsx';
      }
      String filePath = '${directory.path}/$baseFileName';
      int fileCounter = 1;

      // Cek jika file dengan nama tersebut sudah ada
      while (File(filePath).existsSync()) {
        if (label != '') {
          filePath =
              '${directory.path}/rekapan_${label.replaceAll(" ", "_")} ($fileCounter).xlsx';
        } else {
          filePath = '${directory.path}/rekapan_pengajuan ($fileCounter).xlsx';
        }
        fileCounter++;
      }

      // 8) Simpan file ke direktori
      File file = File(filePath);
      await file.writeAsBytes(excel.encode()!);

      // 9) Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File berhasil diunduh: $filePath')),
      );
    } catch (e) {
      // Tampilkan pesan error jika ada masalah
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengunduh file: $e')),
      );
    }
  }

  /// --------------------------------------------------------------------------
  ///  Minta Storage Permission (Android)
  /// --------------------------------------------------------------------------
  static Future<bool> _requestStoragePermission() async {
    final build = await DeviceInfoPlugin().androidInfo;

    if (build.version.sdkInt >= 30) {
      // For Android 11+ (SDK 30 and above)
      var result = await Permission.manageExternalStorage.request();
      return result.isGranted;
    } else {
      // For Android versions below 11
      if (await Permission.storage.isGranted) {
        return true;
      } else {
        var result = await Permission.storage.request();
        return result.isGranted;
      }
    }
  }
}
