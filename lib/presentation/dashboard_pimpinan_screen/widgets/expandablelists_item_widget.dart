import 'package:flutter/material.dart';

import '../../detail_absensi_manual_pimpinan_screen/detail_absensi_manual_pimpinan_screen.dart';
import '../../detail_pengajuan_cuti_pimpinan_screen/detail_pengajuan_cuti_pimpinan_screen.dart';
import '../../detail_pengajuan_kipapp_ketua_tim_screen/detail_pengajuan_kipapp_ketua_tim_screen.dart';
import '../../detail_pengajuan_kipapp_ketua_tim_screen_tahun/detail_pengajuan_kipapp_ketua_tim_screen_tahun.dart';
import '../../../services/excel_service.dart';

class ExpandablelistsItemWidget extends StatelessWidget {
  final VoidCallback? onTapRowone;
  final List<Map<String, dynamic>> tableData;
  final String label;

  ExpandablelistsItemWidget({
    Key? key,
    this.onTapRowone,
    required this.tableData,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hitung jumlah pengajuan dengan status TEAM_APPROVED
    final int teamApprovedCount = tableData
        .where((row) => row['Status'] == 'Menunggu Persetujuan')
        .length;

    return Container(
      margin: EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 14),
          title: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (teamApprovedCount >
                  0) // Tampilkan notifikasi hanya jika ada data
                Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$teamApprovedCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Icon(Icons.keyboard_arrow_down), // Icon dropdown default
            ],
          ),
          children: [
            _buildDataTable(context),
            SizedBox(height: 8),
            _buildDownloadButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: IntrinsicColumnWidth(),
            2: IntrinsicColumnWidth(),
          },
          border: TableBorder.all(color: Colors.black12, width: 1),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              children: [
                _buildHeaderCell('Nama'),
                _buildHeaderCell('Jenis Pengajuan'),
                _buildHeaderCell('Status'),
              ],
            ),
            ...tableData.map((row) {
              return TableRow(
                children: [
                  _buildMultiLineCell(context, row['Nama'] ?? '', row),
                  _buildMultiLineCell(
                      context, row['Jenis Pengajuan'] ?? '', row),
                  _buildStatusCell(row['Status'] ?? ''),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildMultiLineCell(context, String text, Map<String, dynamic> row) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, row),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          maxLines: null,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void _navigateToDetail(context, Map<String, dynamic> row) {
    final submissionType = row['Jenis Pengajuan'];
    if (submissionType == "Presensi Manual") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailAbsensiManualPimpinanScreen(
            data: row, // Kirim data ke halaman detail
          ),
        ),
      );
    } else if (submissionType == "Pengajuan Cuti") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPengajuanCutiPimpinanScreen(
            data: row, // Kirim data ke halaman detail
          ),
        ),
      );
    } else if (submissionType == "KiP APP") {
      final kipAppType = row['Submission Data']['submission_data']
          ['kipapp_type']; // Tambahkan `kipAppType` ke data jika diperlukan
      if (kipAppType == "Bulanan") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPengajuanKipappKetuaTimScreen(
              data: row, // Kirim data ke halaman detail
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPengajuanKipappKetuaTimScreenTahun(
              data: row, // Kirim data ke halaman detail
            ),
          ),
        );
      }
    }
  }

  Widget _buildStatusCell(String status) {
    if (status.isEmpty) {
      return SizedBox.shrink();
    }

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
        statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: ElevatedButton.icon(
        onPressed: () => _downloadTableData(context),
        icon: Icon(Icons.download),
        label: Text('Unduh Rekapan'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 155, 155, 155),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Future<void> _downloadTableData(BuildContext context) async {
    await ExcelService.downloadRekapan(context, tableData, label);
  }
}
