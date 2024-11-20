import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';

// ignore_for_file: must_be_immutable
class ExpandablelistsItemWidget extends StatelessWidget {
  ExpandablelistsItemWidget({Key? key, this.onTapRowone, required this.tableData}) : super(key: key);

  VoidCallback? onTapRowone;
  final List<Map<String, String>> tableData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder10,
        boxShadow: [
          BoxShadow(
            color: appTheme.blue4003f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 0),
          )
        ],
      ),
      margin: EdgeInsets.only(right: 4.h),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(
            left: 14.h,
            right: 4.h,
          ),
          title: SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    "IPDS",
                    style: CustomTextStyles.titleSmallExtraBold,
                  ),
                )
              ],
            ),
          ),
          children: [
            _buildDataTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      width: double.infinity, // Memastikan tabel memenuhi lebar dropdown
      padding: EdgeInsets.all(8.h),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(appTheme.whiteA700),
        dataRowColor: MaterialStateProperty.all(appTheme.whiteA700),
        columnSpacing: 8, // Jarak antar kolom
        columns: [
          DataColumn(
            label: Flexible(
              child: Center(
                child: Text(
                  'Nama',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black), // Warna teks hitam
                ),
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: Center(
                child: Text(
                  'Jenis Pengajuan',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black), // Warna teks hitam
                ),
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: Center(
                child: Text(
                  'Status',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black), // Warna teks hitam
                ),
              ),
            ),
          ),
        ],
        rows: tableData.map((row) {
          return DataRow(
            cells: [
              _buildMultiLineCell(row['Nama']!),
              _buildMultiLineCell(row['Jenis Pengajuan']!),
              _buildStatusCell(row['Status']!), // Memanggil fungsi khusus untuk status
            ],
          );
        }).toList(),
      ),
    );
  }

  DataCell _buildMultiLineCell(String text) {
    return DataCell(
      Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible, // Memungkinkan teks melanjutkan ke bawah
          maxLines: null, // Tidak ada batasan baris
          style: TextStyle(color: Colors.black), // Warna teks hitam
        ),
      ),
    );
  }

  DataCell _buildStatusCell(String status) {
    // Tentukan warna berdasarkan status
    Color statusColor;
    switch (status) {
      case 'Disetujui':
        statusColor = Colors.green;
        break;
      case 'Ditolak':
        statusColor = Colors.red;
        break;
      case 'Menunggu Persetujuan':
        statusColor = Colors.yellow;
        break;
      default:
        statusColor = Colors.grey; // Warna default jika status tidak dikenali
    }

    return DataCell(
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(4.h),
          ),
          child: Text(
            status,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: null,
            style: TextStyle(
              color: Colors.black, // Teks warna hitam untuk kontras
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
