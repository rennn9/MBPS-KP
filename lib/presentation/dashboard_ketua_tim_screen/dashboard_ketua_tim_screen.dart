import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/listpresensiman1_item_widget.dart';
import '../profile_info_ketua_tim_screen/profile_info_ketua_tim_screen.dart';
import '../notifikasi_ketua_tim_screen/notifikasi_ketua_tim_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class DashboardKetuaTimScreen extends StatefulWidget {
  DashboardKetuaTimScreen({Key? key}) : super(key: key);

  @override
  _DashboardKetuaTimScreenState createState() =>
      _DashboardKetuaTimScreenState();
}

class _DashboardKetuaTimScreenState extends State<DashboardKetuaTimScreen> {
  List<String> dropdownItemList = [
    "Semua Permohonan",
    "Hari Ini",
    "Minggu Ini",
    "Bulan Ini"
  ];
  int selectedIndex = 0;
  String selectedDropdownItem = "Semua Permohonan";
  final FocusNode dropdownFocusNode = FocusNode();

  // Data tabel (contoh, bisa diganti dengan data dari database atau API)
  List<Map<String, String>> tableData = [
    {'Nama': 'John Doe', 'Jenis Pengajuan': 'Cuti', 'Status': 'Diterima'},
    {'Nama': 'Jane Smith', 'Jenis Pengajuan': 'Presensi Manual', 'Status': 'Ditolak'},
    {'Nama': 'Alex Johnson', 'Jenis Pengajuan': 'KiP APP', 'Status': 'Menunggu'},
  ];

    Future<void> _downloadRekapan() async {
    // Membuat data CSV dari tableData
    List<List<String>> csvData = [
      ['Nama', 'Jenis Pengajuan', 'Status'], // Header tabel
      ...tableData
          .map((row) => [row['Nama']!, row['Jenis Pengajuan']!, row['Status']!])
    ];

    // Konversi ke string CSV
    String csv = const ListToCsvConverter().convert(csvData);

    try {
      // Mendapatkan direktori unduhan
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/rekapan_pengajuan.csv';

      // Menyimpan file CSV
      final file = File(path);
      await file.writeAsString(csv);

      // Menampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File berhasil diunduh ke $path')),
      );
    } catch (e) {
      // Menampilkan pesan error jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengunduh file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 48),
                  decoration: BoxDecoration(
                    color: appTheme.cyan100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildListpresensiman(context),
                        SizedBox(height: 14),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownMenu<String>(
                            initialSelection: dropdownItemList.first,
                            onSelected: (String? value) {
                              setState(() {
                                selectedDropdownItem = value!;
                              });
                            },
                            dropdownMenuEntries: dropdownItemList.map((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
                            }).toList(),
                            focusNode: dropdownFocusNode..canRequestFocus = false,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Tombol Download Rekapan
                        ElevatedButton.icon(
                          onPressed: _downloadRekapan,
                          icon: Icon(Icons.download),
                          label: Text('Download Rekapan'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color.fromARGB(255, 62, 155, 151),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Tabel Data Pengajuan
                        _buildDataTable(),
                        SizedBox(height: 210),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildColumnprice(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListpresensiman(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: List.generate(
            3,
            (index) {
              final texts = ["Presensi\nManual", "Pengajuan\nCuti", "KiP APP"];
              final imagePaths = [
                ImageConstant.imgEdit,
                ImageConstant.imgCalendar,
                ImageConstant.imgDownload
              ];
              return Listpresensiman1ItemWidget(
                text: texts[index],
                imagePath: imagePaths[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedTextColor: Color(0xFF3E9B97),
              );
            },
          ),
        ),
      ),
    );
  }

Widget _buildColumnprice(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(top: 24, right: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLogoBps,
                  height: 28,
                  width: 40,
                  margin: EdgeInsets.only(left: 26),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 1),
                    child: Text(
                      "Government Approval",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgMdnotificationsnone,
                  height: 24,
                  width: 26,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotifikasiKetuaTimScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileInfoKetuaTimScreen(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 18),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                  border: Border.all(color: appTheme.gray30001, width: 1),
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgAvatars3dAvatar21,
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi, Ketua Tim",
                              style: theme.textTheme.titleSmall),
                          Text("IPDS", style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildDataTable() {
    return Container(
      width: double.infinity, // Memastikan tabel memenuhi lebar layar
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.white),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        columnSpacing: 16, // Jarak antar kolom
        columns: [
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Nama',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black), // Warna teks hitam
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Jenis Pengajuan',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black), // Warna teks hitam
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Status',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black), // Warna teks hitam
                ),
              ),
            ),
          ),
        ],
        rows: tableData.map((row) {
          return DataRow(
            cells: [
              _buildCenteredCell(row['Nama']!),
              _buildCenteredCell(row['Jenis Pengajuan']!),
              _buildStatusCell(row['Status']!), // Memanggil fungsi khusus untuk status
            ],
          );
        }).toList(),
      ),
    );
  }


  DataCell _buildCenteredCell(String text) {
    return DataCell(
      Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2, // Memungkinkan teks dibungkus
          style: TextStyle(color: Colors.black), // Warna teks hitam
        ),
      ),
    );
  }

  DataCell _buildStatusCell(String status) {
    // Tentukan warna latar belakang berdasarkan status
    Color statusColor;
    switch (status) {
      case 'Diterima':
        statusColor = Colors.green;
        break;
      case 'Ditolak':
        statusColor = Colors.red;
        break;
      case 'Menunggu':
        statusColor = Colors.yellow;
        break;
      default:
        statusColor = Colors.grey; // Warna default jika status tidak dikenali
    }

    return DataCell(
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: TextStyle(color: Colors.black), // Tetap warna teks hitam
          ),
        ),
      ),
    );
  }
}
