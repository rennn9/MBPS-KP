import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:excel/excel.dart';

class ExpandablelistsItemWidget extends StatelessWidget {
  final VoidCallback? onTapRowone;
  final List<Map<String, String>> tableData;
  final String label;

  ExpandablelistsItemWidget({
    Key? key,
    this.onTapRowone,
    required this.tableData,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top : 1),
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
          children: [
            _buildDataTable(),
            SizedBox(height: 8),
            _buildDownloadButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
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
                  _buildMultiLineCell(row['Nama'] ?? ''),
                  _buildMultiLineCell(row['Jenis Pengajuan'] ?? ''),
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

  Widget _buildMultiLineCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        maxLines: null,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildStatusCell(String status) {
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
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      // Header
      sheetObject.appendRow(['Nama', 'Jenis Pengajuan', 'Status']);

      // Data
      for (var row in tableData) {
        sheetObject.appendRow([
          row['Nama'] ?? '',
          row['Jenis Pengajuan'] ?? '',
          row['Status'] ?? '',
        ]);
      }

      // Save file
      var directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/rekapan_${label}.xlsx';
      File file = File(path);
      await file.writeAsBytes(excel.encode()!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File berhasil diunduh: $path')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin penyimpanan ditolak')),
      );
    }
  }
}
