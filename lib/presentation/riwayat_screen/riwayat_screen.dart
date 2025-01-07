import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/riwayat_one_item_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

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

  /// Membuat file PDF berdasarkan riwayatItems
  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Rekapan Riwayat",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              ...riwayatItems.map((item) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Judul: ${item.title}"),
                    pw.Text("Deskripsi: ${item.description}"),
                    pw.Text("Status: ${item.status}"),
                    pw.Text("Tanggal: ${item.date}"),
                    pw.Divider(),
                  ],
                );
              }).toList(),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  /// Menampilkan dialog unduhan PDF
  void _downloadPdf(BuildContext context) async {
    final pdfData = await _generatePdf();

    await Printing.sharePdf(bytes: pdfData, filename: 'rekapan_riwayat.pdf');
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
              onPressed: () => _downloadPdf(context),
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
