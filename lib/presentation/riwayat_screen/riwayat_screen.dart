import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/riwayat_one_item_widget.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RiwayatItem {
  final String title;
  final String description;
  final String status;
  final String date;
  final String route;

  RiwayatItem({
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.route,
  });
}

class RiwayatScreen extends StatelessWidget {
  RiwayatScreen({Key? key}) : super(key: key);

  final List<RiwayatItem> riwayatItems = [
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti 1 hari",
      status: "Disetujui",
      date: "18 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiScreen,
    ),
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti setengah hari",
      status: "Disetujui",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiOneScreen,
    ),
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti setengah hari",
      status: "Ditolak",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiTwoScreen,
    ),
    RiwayatItem(
      title: "Pengajuan Cuti",
      description: "Cuti 1 hari",
      status: "Disetujui",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiThreeScreen,
    ),
    RiwayatItem(
      title: "Presensi Manual",
      description: "WFOL",
      status: "Ditolak",
      date: "15 Oktober 2024",
      route: AppRoutes.detailRiwayatPegawaiFourScreen,
    ),
  ];

  /// Membuat file Excel berdasarkan riwayatItems
  Future<File> _generateExcel() async {
    var excel = Excel.createExcel(); // Membuat file Excel baru
    Sheet sheet = excel['Riwayat']; // Membuat sheet bernama "Riwayat"

    // Menambahkan header
    sheet.appendRow(['Judul', 'Deskripsi', 'Status', 'Tanggal']);

    // Menambahkan data
    for (var item in riwayatItems) {
      sheet.appendRow([item.title, item.description, item.status, item.date]);
    }

    // Menyimpan file Excel ke dalam direktori sementara
    final directory =
        await getApplicationDocumentsDirectory(); // Direktori aplikasi
    final path = "${directory.path}/rekapan_riwayat.xlsx";
    final file = File(path);
    await file.writeAsBytes(excel.encode()!);

    return file;
  }

  /// Menampilkan notifikasi lokasi file disimpan
  void _saveExcelLocally(BuildContext context) async {
    try {
      final file = await _generateExcel();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("File berhasil disimpan di: ${file.path}"),
          action: SnackBarAction(
            label: "Buka",
            onPressed: () async {
              // Gunakan aplikasi file manager untuk membuka lokasi file
              await Process.run('xdg-open', [file.path]);
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan file: $e")),
      );
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
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: AppbarTitle(
            text: "Riwayat",
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.download, color: Colors.white),
              onPressed: () => _saveExcelLocally(context),
              tooltip: "Download Rekapan",
            ),
          ],
          styleType: Style.bgFillTeal200,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 22.h),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  itemCount: riwayatItems.length,
                  itemBuilder: (context, index) {
                    final item = riwayatItems[index];
                    return RiwayatOneItemWidget(
                      title: item.title,
                      description: item.description,
                      status: item.status,
                      date: item.date,
                      onTapRow18oktober: () {
                        Navigator.pushNamed(context, item.route);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
