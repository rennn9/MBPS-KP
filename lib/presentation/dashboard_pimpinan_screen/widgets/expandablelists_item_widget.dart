import 'package:flutter/material.dart';

class ExpandableListsExample extends StatelessWidget {
  final List<Map<String, String>> dataIPDS = [
    {'Nama': 'Alice', 'Jenis Pengajuan': 'Cuti', 'Status': 'Disetujui'},
    {'Nama': 'Bob', 'Jenis Pengajuan': 'Izin', 'Status': 'Ditolak'},
  ];

  final List<Map<String, String>> dataAnother = [
    {'Nama': 'Charlie', 'Jenis Pengajuan': 'Lembur', 'Status': 'Menunggu Persetujuan'},
    {'Nama': 'David', 'Jenis Pengajuan': 'Cuti', 'Status': 'Disetujui'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expandable Dropdown Example")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ExpandablelistsItemWidget(
                tableData: dataIPDS,
                onTapRowone: () {
                  print("Dropdown IPDS clicked");
                },
                label: "IPDS",
              ),
              SizedBox(height: 16), // Jarak antar dropdown
              ExpandablelistsItemWidget(
                tableData: dataAnother,
                onTapRowone: () {
                  print("Dropdown Another clicked");
                },
                label: "UMUM",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
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
        scrollDirection: Axis.vertical, // Hanya memungkinkan scroll vertikal
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
        maxLines: null, // Mengizinkan teks sambung ke bawah
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
        overflow: TextOverflow.visible,
        maxLines: null,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
